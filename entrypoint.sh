#!/usr/bin/env bash
set -euo pipefail

# create data files if not existing
[[ -d ./data ]] || mkdir -p ./data
[[ -f ./data/status.mv.db ]] || touch ./data/status.mv.db
[[ -f ./data/config.yml ]] || cp ./config.yml ./data/config.yml

# run the app
java -jar status-assembly-0.1.jar
