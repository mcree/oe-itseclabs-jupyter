# Jupyter environment for IT Security labs at Óbuda University

This repository contains practice materials and setup 
files for the jupyter environments used during lab sessions.

The repo aims to be bilingual (primary language is hungarian,
but most things are also present in english)

The environment contains .NET Core Interactive as an additional interpreter.

# Usage

For local usage, install [Docker](https://docs.docker.com/install/).

## `.env` configuration

The project uses a root-level `.env` file for defaults.

Current variables:

- `NB_USER`: Linux username inside the container
- `NB_UID`: target UID for the notebook user during image build
- `NB_PASSWORD`: password set for `NB_USER` inside the image
- `JUPYTER_TOKEN`: fixed token used by JupyterLab authentication

## Start with launcher script

Use:

```bash
./launch.sh
```

What it does:

- Runs `docker compose build`
- Runs `docker compose up`
- Waits for JupyterLab to become reachable
- Opens the browser at:
  `http://127.0.0.1:8888/lab?token=${JUPYTER_TOKEN}`

Note: `launch.sh` overrides `NB_UID` with your host user ID (`id -u`) so the mounted workspace remains writable.

## Direct Docker Compose usage

Build:

```bash
docker compose build
```

Run:

```bash
docker compose up
```

Open JupyterLab manually at:

`http://127.0.0.1:8888/lab?token=<value from .env:JUPYTER_TOKEN>`

# Contribute

Pull requests are welcome.
