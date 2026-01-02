# shellcheck shell=bash

function log_color() {
  local color_code="$1"
  shift
  printf "\033[${color_code}m%s\033[0m\n" "$*" >&2
}

function log_red() {
  log_color "0;31" "$@"
}

function log_blue() {
  log_color "0;34" "$@"
}

function log_green() {
  log_color "1;32" "$@"
}

function log_yellow() {
  log_color "1;33" "$@"
}

function log_info() {
  log_blue "ℹ️" "$@"
}

function log_error() {
  log_red "❌" "$@"
}

function error() {
  log_error "$@"
  exit 1
}

function log_task() {
  log_blue "🔃" "$@"
}

function log_manual_action() {
  log_red "⚠️" "$@"
}

function log_c() {
  log_yellow "👉" "$@"
}

function c() {
  log_c "$@"
  "$@"
}

function c_exec() {
  log_c "$@"
  exec "$@"
}
