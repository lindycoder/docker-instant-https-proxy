#!/bin/bash -eu
COMPOSE="docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):$(pwd) -w $(pwd) docker/compose:1.22.0 --no-ansi -f test/docker-compose.yml"

set -x

teardown() {
    ${COMPOSE} logs
    ${COMPOSE} down
}
trap teardown INT TERM EXIT

${COMPOSE} build
${COMPOSE} up -d

wget -q -O sbtest.sh https://github.com/internap/sbtest/releases/download/0.1.7/sbtest.sh
chmod +x sbtest.sh

COMPOSE="${COMPOSE} -f test/docker-compose.curl.yml" ./sbtest.sh --src test --tests test

