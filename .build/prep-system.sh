#!/usr/bin/env bash
#
# this script must be run as root
#
cd "$(dirname $0)"
[[ -f ".flag-prep-system-done" ]] && exit 0
set -e +x
#pipenv lock
#pipenv install --system
#pipenv run pip3 freeze > .build/requirements.txt
#jupyter contrib nbextension install
remote_ikernel manage --add --host=itseclabs --kernel_cmd="sudo python3 -m zsh_jupyter_kernel -f {connection_file}" --name="ZSH" --system --language=zsh --interface=ssh --workdir=/tmp
jupyter serverextension enable --py jupyterlab_git
python3 -m sshkernel install
jupyter nbextensions_configurator enable
jupyter labextension install --no-build @jupyter-widgets/jupyterlab-manager@1.1
jupyter labextension install --no-build @jupyterlab/git
jupyter lab build
touch .flag-prep-system-done
exit 0
