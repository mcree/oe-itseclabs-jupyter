#!/usr/bin/env bash
set -euo pipefail

image_name="mcreeiw/oe-itseclabs-jupyter:dist"

docker build \
  --build-arg NB_UID=10000 \
  --build-arg NB_USER=hallgato \
  -t "${image_name}" \
  .

docker push "${image_name}"
