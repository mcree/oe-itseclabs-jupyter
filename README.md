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

For local usage, you should [install docker](https://docs.docker.com/install/) as well as
[pipenv](https://github.com/pypa/pipenv), then you can 
set up and start the Jupyter service with:

    pipenv run repo2docker .

# Contribute

Pull requests are welcome.