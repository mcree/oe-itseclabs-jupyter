#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"
: "${NB_USER:?NB_USER must be set}"
: "${NB_UID:?NB_UID must be set}"
: "${NB_PASSWORD:?NB_PASSWORD must be set}"
: "${VENV_PATH:=/opt/itseclabs-venv}"

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
    dotnet-sdk-10.0 \
    python3 \
    python3-venv \
    locales \
    git \
    sudo \
    hashcat \
    fcrackzip \
    pdfcrack \
    ca-certificates

locale-gen hu_HU.UTF-8
update-locale LANG=hu_HU.UTF-8 LC_ALL=hu_HU.UTF-8

if id -u "${NB_USER}" >/dev/null 2>&1; then
    usermod --uid "${NB_UID}" --home "/home/${NB_USER}" --shell /bin/bash \
        --append --groups sudo "${NB_USER}"
elif [ "${NB_UID}" = "1000" ] && id -u ubuntu >/dev/null 2>&1; then
    usermod --login "${NB_USER}" ubuntu
    usermod --uid "${NB_UID}" --home "/home/${NB_USER}" --shell /bin/bash \
        --append --groups sudo "${NB_USER}"
else
    useradd --create-home --uid "${NB_UID}" --shell /bin/bash --groups sudo "${NB_USER}"
fi
echo "${NB_USER}:${NB_PASSWORD}" | chpasswd

mkdir -p "/home/${NB_USER}"
chown -R "${NB_UID}:${NB_UID}" "/home/${NB_USER}"
install -m 0755 bin/* /usr/local/bin/

python3 -m venv "${VENV_PATH}"
"${VENV_PATH}/bin/pip" install --no-cache-dir --upgrade pip
"${VENV_PATH}/bin/pip" install --no-cache-dir -r requirements.txt

export PATH="${VENV_PATH}/bin:$PATH"

# Keep this idempotent: if the kernel already exists, this may fail.
remote_ikernel manage --add --host=itseclabs --kernel_cmd="sudo ${VENV_PATH}/bin/python -m zsh_jupyter_kernel -f {connection_file}" --name="ZSH" --system --language=zsh --interface=ssh --workdir=/tmp || true
jupyter server extension enable --py jupyterlab_git --sys-prefix
python -m sshkernel install

apt-get clean
rm -rf /var/lib/apt/lists/*
