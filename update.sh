#!/usr/bin/env bash

# get photopush directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
cd $DIR

# update
git fetch --all
git reset --hard origin/master
