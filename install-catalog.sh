#!/usr/bin/env bash

# Install every community theme currently listed on omarchythemes.com.
# Existing user and stock themes are skipped. The active theme is restored.

set -u

readonly catalog_url="https://omarchythemes.com/"
readonly themes_root="${HOME}/.config/omarchy/themes"
readonly stock_root="/usr/share/omarchy/themes"
dry_run=0

if [[ "${1:-}" == "--dry-run" ]]; then
  dry_run=1
elif [[ $# -gt 0 ]]; then
  printf 'Usage: %s [--dry-run]\n' "${0##*/}" >&2
  exit 2
fi

for command_name in curl git omarchy sed sort; do
  if ! command -v "${command_name}" >/dev/null 2>&1; then
    printf 'Error: %s is required.\n' "${command_name}" >&2
    exit 1
  fi
done

mkdir -p -- "${themes_root}"
temporary_directory="$(mktemp -d -t omarchy-catalog.XXXXXX)"
readonly temporary_directory

cleanup() {
  rm -rf -- "${temporary_directory}"
}
trap cleanup EXIT

current_theme="$(omarchy theme current 2>/dev/null || true)"
homepage="${temporary_directory}/index.html"
slugs_file="${temporary_directory}/slugs"
failures_file="${temporary_directory}/failures"

printf 'Reading the Omarchy Themes catalog...\n'
curl -fsSL --retry 3 --retry-delay 2 -o "${homepage}" -- "${catalog_url}"

sed -nE 's#.*href="https://omarchythemes\.com/themes/([^"/?#]+)".*#\1#p' "${homepage}" \
  | sort -u > "${slugs_file}"

catalog_count="$(wc -l < "${slugs_file}")"
installed=0
skipped=0
failed=0
processed=0

while IFS= read -r slug; do
  [[ -n "${slug}" ]] || continue
  processed=$((processed + 1))
  detail_page="${temporary_directory}/theme-${processed}.html"

  # Built-in and conventionally named user themes need no detail-page lookup.
  # This also avoids treating official catalog cards (which have no repository
  # button) as failures.
  if [[ -d "${themes_root}/${slug}" || -d "${stock_root}/${slug}" ]]; then
    printf '[%d/%d] %-28s skipped (already available)\n' "${processed}" "${catalog_count}" "${slug}"
    skipped=$((skipped + 1))
    continue
  fi

  if ! curl -fsSL --retry 3 --retry-delay 2 -o "${detail_page}" -- "${catalog_url}themes/${slug}"; then
    printf '[%d/%d] %-28s FAILED (catalog page)\n' "${processed}" "${catalog_count}" "${slug}"
    printf '%s\tcatalog page unavailable\n' "${slug}" >> "${failures_file}"
    failed=$((failed + 1))
    continue
  fi

  repo_url="$(sed -nE 's#.*href="(https://github\.com/[^"?#]+)".*#\1#p' "${detail_page}" | head -n 1)"
  if [[ -z "${repo_url}" ]]; then
    printf '[%d/%d] %-28s FAILED (repository missing)\n' "${processed}" "${catalog_count}" "${slug}"
    printf '%s\trepository missing\n' "${slug}" >> "${failures_file}"
    failed=$((failed + 1))
    continue
  fi

  repo_url="${repo_url%/}"
  repo_url="${repo_url%.git}.git"
  repo_name="$(basename -- "${repo_url}" .git)"
  theme_name="$(printf '%s' "${repo_name}" | sed -E 's/^omarchy-//; s/-theme$//' | tr '[:upper:]' '[:lower:]')"

  if [[ -d "${themes_root}/${theme_name}" || -d "${stock_root}/${theme_name}" ]]; then
    printf '[%d/%d] %-28s skipped (already available)\n' "${processed}" "${catalog_count}" "${slug}"
    skipped=$((skipped + 1))
    continue
  fi

  if (( dry_run == 1 )); then
    printf '[%d/%d] %-28s would install %s\n' "${processed}" "${catalog_count}" "${slug}" "${repo_url}"
    installed=$((installed + 1))
    continue
  fi

  printf '[%d/%d] %-28s installing...\n' "${processed}" "${catalog_count}" "${slug}"
  if omarchy theme install "${repo_url}"; then
    installed=$((installed + 1))
  else
    printf '%s\t%s\n' "${slug}" "${repo_url}" >> "${failures_file}"
    failed=$((failed + 1))
  fi
done < "${slugs_file}"

if (( dry_run == 0 )) && [[ -n "${current_theme}" ]]; then
  printf 'Restoring active theme: %s\n' "${current_theme}"
  omarchy theme set "${current_theme}" || printf 'Warning: could not restore %s.\n' "${current_theme}" >&2
fi

printf '\nCatalog: %d | Installed: %d | Skipped: %d | Failed: %d\n' \
  "${catalog_count}" "${installed}" "${skipped}" "${failed}"

if [[ -s "${failures_file}" ]]; then
  printf 'Failures:\n'
  sed 's/^/  /' "${failures_file}"
fi

(( failed == 0 ))
