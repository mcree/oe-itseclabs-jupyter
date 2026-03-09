#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"
export PATH="/opt/itseclabs-venv/bin:$PATH"

# Keep this idempotent: if the kernel already exists, this may fail.
remote_ikernel manage --add --host=itseclabs --kernel_cmd="sudo /opt/itseclabs-venv/bin/python -m zsh_jupyter_kernel -f {connection_file}" --name="ZSH" --system --language=zsh --interface=ssh --workdir=/tmp || true
jupyter server extension enable --py jupyterlab_git --sys-prefix
python -m sshkernel install
