#!/bin/bash
pipenv lock
pipenv install
pipenv run pip3 freeze > .build/requirements.txt
