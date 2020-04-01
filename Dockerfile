FROM ubuntu:18.04

ARG NB_USER=hallgato
ARG NB_UID=10000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}

ENV HOME /
USER root

ENV PATH="${PATH}:/home/${NB_USER}/.dotnet/tools"

COPY ./ /home/${USER}/oe-itseclabs/
RUN chown -R ${NB_UID} /home/${NB_USER}

WORKDIR /home/${USER}/oe-itseclabs/.build/
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y remove python2.7-minimal && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install python3 python3-distutils python3-pip && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.6 10 && \
    pip3 install ansible==2.9.4
RUN ansible-playbook --connection=local --inventory localhost, playbook.yml && \
    apt-get clean

ENV HOME=/home/${NB_USER}
USER ${USER}
WORKDIR ${HOME}/oe-itseclabs

CMD jupyter lab --ip 0.0.0.0
