#!/usr/bin/env bash
#
# this script must be run as root
#
cd "$(dirname $0)"
[[ -f ".flag-prep-system-done" ]] && exit 0
set -e +x
#pipenv lock
#pipenv install --system
#pipenv run pip3 freeze > reqiurements.txt
#jupyter contrib nbextension install
#jupyter serverextension enable --py jupyterlab_git
jupyter nbextensions_configurator enable
jupyter labextension install --no-build @jupyter-widgets/jupyterlab-manager@2.0
#jupyter labextension install --no-build @jupyterlab/git
jupyter lab build
touch .flag-prep-system-done
exit 0
