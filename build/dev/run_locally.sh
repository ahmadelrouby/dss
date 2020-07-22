#!/bin/bash

# This script will deploy a standalone DSS instance with docker-compose.  See
# standalone_instance.md for more information.

if [[ -z $(which docker-compose) ]]; then
  echo "docker-compose is required but not installed.  Visit https://docs.docker.com/compose/install/ to install."
  exit 1
fi

OS=$(uname)
if [[ $OS == "Darwin" ]]; then
	# OSX uses BSD readlink
	BASEDIR="$(dirname $0)"
else
	BASEDIR=$(readlink -e "$(dirname "$0")")
fi

cd "${BASEDIR}" || exit 1

DC_COMMAND=${1:-up}

if [[ $DC_COMMAND == "down" ]]; then
  DC_OPTIONS="--volumes --remove-orphans"
else
  DC_OPTIONS=""
fi

docker-compose -f docker-compose_dss.yaml -p dss_sandbox $DC_COMMAND $DC_OPTIONS
