#!/usr/bin/env bash
#
# this script must be run unprivileged
#
cd "$(dirname $0)"
[[ -f ".flag-prep-user-done" ]] && exit 0
set -e +x
dotnet tool install -g dotnet-script
dotnet tool install -g --add-source "https://dotnet.myget.org/F/dotnet-try/api/v3/index.json" Microsoft.dotnet-interactive
dotnet interactive jupyter install
jupyter lab workspaces import ../workspaces/ssh.json
touch .flag-prep-user-done
exit 0
