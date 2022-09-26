#!/bin/bash

set -e
set -o pipefail

CONTAINER_IMAGE='docker.io/library/ruby:3.1-bullseye'
COMMAND=${@}

CONTAINER_RUN='podman run'

command -v podman > /dev/null 2>&1 || {
  CONTAINER_RUN="docker run --user $(id -u):$(id -g)"
}

${CONTAINER_RUN} \
  -e JEKYLL_ENV="${JEKYLL_ENV}" \
  -e LC_ALL='C.UTF-8' `# required for html-proofer to work correctly in the container` \
  --workdir "${PWD}" \
  -v "${PWD}:${PWD}:Z" \
  --pull=always \
  --rm=true \
  --entrypoint=/bin/bash \
  "${CONTAINER_IMAGE}" -c "${COMMAND}"
