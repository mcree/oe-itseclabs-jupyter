#!/usr/bin/env bash
#
# this script must be run as root
#
cd "$(dirname $0)"
[[ -f ".flag-prep-system-done" ]] && exit 0
set -e +x
export PATH="/opt/itseclabs-venv/bin:$PATH"
remote_ikernel manage --add --host=itseclabs --kernel_cmd="sudo /opt/itseclabs-venv/bin/python -m zsh_jupyter_kernel -f {connection_file}" --name="ZSH" --system --language=zsh --interface=ssh --workdir=/tmp
jupyter server extension enable --py jupyterlab_git --sys-prefix
python -m sshkernel install
jupyter server extension list
touch .flag-prep-system-done
exit 0
