#!/usr/bin/env bash

. ./common.sh

echo -e "${RS}${BLUE} Packaging charts... ${RS}"
helm package ../charts/timescaledb-multinode
RET=$?

if [[ "${RET}" == 0 ]]; then
    helm repo index .

    echo -e "Copying chart packages and index to docs ${RS}"
    # rm -f docs/*.tgz
    rm -f ../docs/*.yaml
    mv ./*.tgz ../docs/
    mv ./index.yaml ../docs/

    echo -e "${BLUE} Now commit and push charts and docs! ${RS}"
else
    echo -e "${RED}Tests failed, charts not packaged! ${RS}"
fi