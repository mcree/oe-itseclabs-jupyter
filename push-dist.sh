#!/usr/bin/env bash
set -euo pipefail

image_name="mcreeiw/oe-itseclabs-jupyter:dist"

if [[ -f ".env" ]]; then
  set -a
  # shellcheck disable=SC1091
  source ".env"
  set +a
fi

: "${NB_UID:?NB_UID must be set (for example in .env)}"
: "${NB_USER:?NB_USER must be set (for example in .env)}"
: "${NB_PASSWORD:?NB_PASSWORD must be set (for example in .env)}"

docker build \
  --build-arg NB_UID="${NB_UID}" \
  --build-arg NB_USER="${NB_USER}" \
  --build-arg NB_PASSWORD="${NB_PASSWORD}" \
  -t "${image_name}" \
  .

docker push "${image_name}"
