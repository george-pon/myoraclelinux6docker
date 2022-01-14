#!/bin/bash
#
# リポジトリにpushする
#

REPO_PREFIX=${REPO_PREFIX:-docker.io/georgesan}

docker tag myoraclelinux6docker:latest ${REPO_PREFIX}/myoraclelinux6docker:latest

docker push ${REPO_PREFIX}/myoraclelinux6docker:latest

