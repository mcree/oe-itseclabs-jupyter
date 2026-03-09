FROM ubuntu:24.04

ARG NB_USER
ARG NB_UID
ARG NB_PASSWORD
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV VENV_PATH=/opt/itseclabs-venv

ENV HOME=/root
USER root

ENV PATH="${VENV_PATH}/bin:${PATH}:/home/${NB_USER}/.dotnet/tools"

COPY ./ /home/${USER}/oe-itseclabs/
WORKDIR /home/${USER}/oe-itseclabs

RUN set -eux; \
    NB_PASSWORD="${NB_PASSWORD}" /home/${USER}/oe-itseclabs/.build/prep-system.sh; \
    sudo -i -u "${NB_USER}" /home/${USER}/oe-itseclabs/.build/prep-user.sh; \
    rm -rf /tmp/* /var/tmp/*

USER ${USER}
ENV HOME=/home/${NB_USER}
WORKDIR ${HOME}/oe-itseclabs

CMD ["jupyter", "lab", "--ip", "0.0.0.0", "--port", "8888", "--no-browser"]
