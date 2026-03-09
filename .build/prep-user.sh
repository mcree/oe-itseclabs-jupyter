#!/usr/bin/env bash
#
# this script must be run unprivileged
#
cd "$(dirname $0)"
[[ -f ".flag-prep-user-done" ]] && exit 0
set -e +x
export PATH="/opt/itseclabs-venv/bin:$HOME/.dotnet/tools:$PATH"
dotnet tool install -g dotnet-script
dotnet tool install -g Microsoft.dotnet-interactive --version 1.0.707101
dotnet interactive jupyter install
jupyter lab workspaces import ../workspaces/ssh.json || true
touch .flag-prep-user-done
exit 0
