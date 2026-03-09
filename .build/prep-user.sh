#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"
export PATH="/opt/itseclabs-venv/bin:$HOME/.dotnet/tools:$PATH"
export DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_INTERACTIVE_CLI_TELEMETRY_OPTOUT=1

dotnet tool update -g dotnet-script || dotnet tool install -g dotnet-script
dotnet tool update -g Microsoft.dotnet-interactive --version 1.0.707101 || \
    dotnet tool install -g Microsoft.dotnet-interactive --version 1.0.707101
mkdir -p "$HOME/.local/share/jupyter/kernels"
dotnet interactive jupyter install --path "$HOME/.local/share/jupyter/kernels"
jupyter lab workspaces import ../workspaces/ssh.json || true
