FROM ubuntu:24.04

ARG NB_USER=hallgato
ARG NB_UID=10000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV VENV_PATH=/opt/itseclabs-venv

ENV HOME=/root
USER root

ENV PATH="${VENV_PATH}/bin:${PATH}:/home/${NB_USER}/.dotnet/tools"

COPY ./ /home/${USER}/oe-itseclabs/
WORKDIR /home/${USER}/oe-itseclabs

RUN set -eux; \
    apt-get update; \
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
        ca-certificates; \
    locale-gen hu_HU.UTF-8; \
    update-locale LANG=hu_HU.UTF-8 LC_ALL=hu_HU.UTF-8; \
    useradd --create-home --uid "${NB_UID}" --shell /bin/bash --groups sudo \
        --password '$6$7uQS525NCE04TAQA$FS4oHPvK6j32ylaB9mN7ftpfDeKus0OhUGvq9GkxbLaFs/OYcgWmEr1oMOxprLhZUqxf0PAKQSinKfbdQ0INv0' \
        "${NB_USER}"; \
    chown -R "${NB_UID}:${NB_UID}" /home/${NB_USER}; \
    install -m 0755 .build/bin/* /usr/local/bin/; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    python3 -m venv "${VENV_PATH}"; \
    "${VENV_PATH}/bin/pip" install --no-cache-dir --upgrade pip; \
    "${VENV_PATH}/bin/pip" install --no-cache-dir -r .build/requirements.txt; \
    /home/${USER}/oe-itseclabs/.build/prep-system.sh; \
    sudo -i -u "${NB_USER}" /home/${USER}/oe-itseclabs/.build/prep-user.sh; \
    rm -rf /tmp/* /var/tmp/*

USER ${USER}
ENV HOME=/home/${NB_USER}
WORKDIR ${HOME}/oe-itseclabs

CMD ["jupyter", "lab", "--ip", "0.0.0.0", "--port", "8888", "--no-browser"]
