#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${SCRIPT_DIR}"

JUPYTER_TOKEN="${JUPYTER_TOKEN:-$(grep -E '^JUPYTER_TOKEN=' "${SCRIPT_DIR}/.env" | head -n1 | cut -d= -f2-)}"
: "${JUPYTER_TOKEN:?JUPYTER_TOKEN must be set (for example in .env)}"
export NB_UID="$(id -u)"

open_url() {
  local url="$1"

  if command -v xdg-open >/dev/null 2>&1; then
    xdg-open "$url" >/dev/null 2>&1 &
    return 0
  fi

  if command -v open >/dev/null 2>&1; then
    open "$url" >/dev/null 2>&1 &
    return 0
  fi

  if command -v powershell.exe >/dev/null 2>&1; then
    powershell.exe -NoProfile -Command "Start-Process '$url'" >/dev/null 2>&1 &
    return 0
  fi

  echo "Could not find a browser launcher. Open this URL manually: $url" >&2
  return 1
}

cleanup() {
  if [[ -n "${compose_pid:-}" ]] && kill -0 "${compose_pid}" 2>/dev/null; then
    kill "${compose_pid}" >/dev/null 2>&1 || true
  fi
}
trap cleanup INT TERM

echo "Using NB_UID=${NB_UID}"
echo "Building JupyterLab image..."
docker compose build

echo "Starting JupyterLab container..."
url="http://127.0.0.1:8888/lab?token=${JUPYTER_TOKEN}"

docker compose up "$@" &
compose_pid=$!

browser_opened=0
if command -v curl >/dev/null 2>&1; then
  for _ in $(seq 1 180); do
    if ! kill -0 "${compose_pid}" 2>/dev/null; then
      break
    fi

    if curl -fsS "${url}" >/dev/null 2>&1; then
      open_url "${url}" || true
      echo "Opened JupyterLab: ${url}"
      browser_opened=1
      break
    fi
    sleep 1
  done
else
  sleep 3
  open_url "${url}" || true
  echo "Opened JupyterLab: ${url}"
  browser_opened=1
fi

if [[ "${browser_opened}" -eq 0 ]]; then
  echo "Jupyter URL (open manually if needed): ${url}"
fi

set +e
wait "${compose_pid}"
status=$?
set -e

exit "$status"
