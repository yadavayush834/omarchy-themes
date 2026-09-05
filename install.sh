#!/usr/bin/env bash

set -Eeuo pipefail

readonly repo_url="https://github.com/yadavayush834/omarchy-themes.git"
readonly themes_root="${HOME}/.config/omarchy/themes"

# Explicit safe mapping from public slug to repository folder.
# Validate the requested name against this list; never build paths
# from unchecked user input.
theme_slug="${1:-mr-robot}"
case "${theme_slug}" in
  mr-robot)
    theme_directory="mr_robot"
    theme_label="Mr. Robot"
    theme_greeting="Mr. Robot is installed and active. Hello, friend."
    ;;
  minimal-drift)
    theme_directory="minimal_drift"
    theme_label="Minimal Drift"
    theme_greeting="Minimal Drift is installed and active. Breathe easy."
    ;;
  blue-lock)
    theme_directory="blue_lock"
    theme_label="Blue Lock"
    theme_greeting="Blue Lock is installed and active. Lock in."
    ;;
  *)
    printf 'Error: unknown theme "%s". Available themes: mr-robot, minimal-drift, blue-lock.\n' "${theme_slug}" >&2
    printf 'Usage: ./install.sh [mr-robot|minimal-drift|blue-lock]\n' >&2
    exit 1
    ;;
esac

readonly target_directory="${themes_root}/${theme_slug}"

temporary_directory=""

cleanup() {
  if [[ -n "${temporary_directory}" && -d "${temporary_directory}" ]]; then
    rm -rf -- "${temporary_directory}"
  fi
}
trap cleanup EXIT

if ! command -v git >/dev/null 2>&1; then
  printf 'Error: git is required.\n' >&2
  exit 1
fi

if ! command -v omarchy >/dev/null 2>&1; then
  printf 'Error: this installer must be run from an Omarchy system.\n' >&2
  exit 1
fi

script_directory="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source_directory="${script_directory}/${theme_directory}"

if [[ ! -d "${source_directory}" ]]; then
  temporary_directory="$(mktemp -d -t omarchy-themes.XXXXXX)"
  git clone --depth 1 --quiet -- "${repo_url}" "${temporary_directory}/repo"
  source_directory="${temporary_directory}/repo/${theme_directory}"
fi

if [[ ! -f "${source_directory}/colors.toml" ]]; then
  printf 'Error: the %s theme files could not be found.\n' "${theme_label}" >&2
  exit 1
fi

mkdir -p -- "${themes_root}"

if [[ -e "${target_directory}" || -L "${target_directory}" ]]; then
  backup_directory="${target_directory}.backup.$(date +%Y%m%d-%H%M%S)"
  mv -- "${target_directory}" "${backup_directory}"
  printf 'Existing theme backed up to %s\n' "${backup_directory}"
fi

cp -a -- "${source_directory}" "${target_directory}"
omarchy theme set "${theme_slug}"

printf '\n%s\n' "${theme_greeting}"
