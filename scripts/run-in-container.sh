#!/bin/bash

set -e
set -o pipefail

CONTAINER_IMAGE=${CONTAINER_IMAGE:-'docker.io/library/ruby:3.1-bookworm'}
COMMAND=${@}

CONTAINER_RUN='podman run'

command -v podman > /dev/null 2>&1 || {
  CONTAINER_RUN="docker run --user $(id -u):$(id -g)"
}

${CONTAINER_RUN} \
  -e LC_ALL='C.UTF-8' `# required for html-proofer to work correctly in the container` \
  --workdir "${PWD}" \
  -v "${PWD}:${PWD}:Z" \
  --pull=always \
  --rm=true \
  --entrypoint=/bin/bash \
  "${CONTAINER_IMAGE}" -c "${COMMAND}"
