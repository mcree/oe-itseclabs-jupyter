[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/mcree/oe-itseclabs-jupyter/master?urlpath=lab)

# Jupyter environment for IT Security labs at Óbuda University

This repository contains practice materials and setup 
files for the jupyter environments used during lab sessions.

The repo aims to be bilingual (primary language is hungarian,
but most things are also present in english)

The environment contains .NET Core Interactive as an additional interpreter.

# Usage

This repository is designed to work with 
[repo2docker](https://repo2docker.readthedocs.io/en/latest/)
for supporting casual usage on [binder](mybinder.org)

For local usage, install [Docker](https://docs.docker.com/install/) and run:

    docker compose up --build

The JupyterLab server will be available on `http://localhost:8888`.

# Contribute

Pull requests are welcome.
