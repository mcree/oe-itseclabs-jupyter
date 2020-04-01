#!/bin/bash
pipenv run repo2docker --push --user-id 10000 --user-name hallgato --no-run --image-name mcreeiw/oe-itseclabs-jupyter:dist .
