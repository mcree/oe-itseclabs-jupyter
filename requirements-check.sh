#!/usr/bin/env bash
set -euo pipefail

python3 -m venv /tmp/itseclabs-reqcheck
trap 'rm -rf /tmp/itseclabs-reqcheck' EXIT

/tmp/itseclabs-reqcheck/bin/pip install --upgrade pip
/tmp/itseclabs-reqcheck/bin/pip install -r .build/requirements.txt
