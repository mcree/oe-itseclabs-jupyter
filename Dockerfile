FROM ubuntu:24.04

ARG NB_USER=hallgato
ARG NB_UID=10000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV VENV_PATH=/opt/itseclabs-venv

ENV HOME /
USER root

ENV PATH="${VENV_PATH}/bin:${PATH}:/home/${NB_USER}/.dotnet/tools"

COPY ./ /home/${USER}/oe-itseclabs/
RUN chown -R ${NB_UID} /home/${NB_USER}

WORKDIR /home/${USER}/oe-itseclabs/.build/
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends ansible python3 python3-venv && \
    rm -rf /var/lib/apt/lists/*
RUN ansible-playbook --connection=local --inventory localhost, playbook.yml && \
    apt-get clean

ENV HOME=/home/${NB_USER}
USER ${USER}
WORKDIR ${HOME}/oe-itseclabs

CMD jupyter lab --ip 0.0.0.0
