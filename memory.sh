#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MEMORY_DIR="${SCRIPT_DIR}/memories"

mkdir -p "$MEMORY_DIR"

usage() {
  echo "Usage: memory.sh <command> <args...>"
  echo "  storeMemory <key> <value>  - Store a key-value pair"
  echo "  getMemory <key>            - Retrieve a value by key"
  echo "  deleteMemory <key>         - Delete a key-value pair"
  exit 1
}

validate_key() {
  local key="$1"
  if [[ -z "$key" ]]; then
    echo "Error: key must not be empty" >&2
    exit 1
  fi
  if [[ "$key" == *"/"* || "$key" == *".."* ]]; then
    echo "Error: key must not contain '/' or '..'" >&2
    exit 1
  fi
}

store_memory() {
  local key="$1"
  local value="$2"
  validate_key "$key"
  printf '%s' "$value" > "${MEMORY_DIR}/${key}"
  echo "Stored memory for key: ${key}"
}

get_memory() {
  local key="$1"
  validate_key "$key"
  local file="${MEMORY_DIR}/${key}"
  if [[ ! -f "$file" ]]; then
    echo "Error: no memory found for key: ${key}" >&2
    exit 1
  fi
  cat "$file"
}

delete_memory() {
  local key="$1"
  validate_key "$key"
  local file="${MEMORY_DIR}/${key}"
  if [[ ! -f "$file" ]]; then
    echo "Error: no memory found for key: ${key}" >&2
    exit 1
  fi
  rm "$file"
  echo "Deleted memory for key: ${key}"
}

if [[ $# -lt 1 ]]; then
  usage
fi

command="$1"
shift

case "$command" in
  storeMemory)
    [[ $# -lt 2 ]] && { echo "Error: storeMemory requires <key> <value>" >&2; exit 1; }
    store_memory "$1" "$2"
    ;;
  getMemory)
    [[ $# -lt 1 ]] && { echo "Error: getMemory requires <key>" >&2; exit 1; }
    get_memory "$1"
    ;;
  deleteMemory)
    [[ $# -lt 1 ]] && { echo "Error: deleteMemory requires <key>" >&2; exit 1; }
    delete_memory "$1"
    ;;
  *)
    echo "Error: unknown command '${command}'" >&2
    usage
    ;;
esac
