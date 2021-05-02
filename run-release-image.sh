#!/bin/bash
#
# test run image
#
function docker-run-myoraclelinux6docker() {
    docker pull georgesan/myoraclelinux6docker:latest
    ${WINPTY_CMD} docker run -i -t --rm \
        -e http_proxy=${http_proxy} -e https_proxy=${https_proxy} -e no_proxy="${no_proxy}" \
        georgesan/myoraclelinux6docker:latest
}
docker-run-myoraclelinux6docker
