#!/usr/bin/env bash
#
set -euo pipefail

script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0" || true)")" && pwd -P)"
source "${script_dir}/scripts/function.bash"

if ! chezmoi="$(command -v chezmoi)"; then
  bin_dir="${HOME}/.local/bin"
  chezmoi="${bin_dir}/chezmoi"
  script_url="https://get.chezmoi.io"
  log_task "Installing chezmoi to '${chezmoi}'"
  if command -v curl >/dev/null; then
    chezmoi_install_script="$(curl -fsSL "${script_url}")"
  elif command -v wget >/dev/null; then
    chezmoi_install_script="$(wget -qO- "${script_url}")"
  else
    error "To install chezmoi, you must have curl or wget."
  fi
  sh -c "${chezmoi_install_script}" -- -b "${bin_dir}"
  unset chezmoi_install_script bin_dir script_url
fi

set -- init --source="${script_dir}" --verbose=false "$@"

if [ -n "${DOTFILES_ONE_SHOT-}" ]; then
  set -- "$@" --one-shot
else
  set -- "$@" --apply
fi
[ -n "${DOTFILES_DEBUG-}" ] && set -- "$@" --debug

log_task "Running 'chezmoi $*'"
exec "${chezmoi}" "$@"
