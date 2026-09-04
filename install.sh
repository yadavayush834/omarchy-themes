#!/usr/bin/env bash

set -Eeuo pipefail

readonly repo_url="https://github.com/yadavayush834/omarchy-themes.git"
readonly theme_directory="mr_robot"
readonly theme_slug="mr-robot"
readonly themes_root="${HOME}/.config/omarchy/themes"
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
  printf 'Error: the Mr. Robot theme files could not be found.\n' >&2
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

printf '\nMr. Robot is installed and active. Hello, friend.\n'
