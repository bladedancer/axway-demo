#!/bin/bash

ROOT=$(dirname ${BASH_SOURCE})

. $ROOT/../util.sh

DEMO_RUN_FAST=1

if [ ! -f '${BASH_SOURCE})/yq' ]; then
    comment "Initial setup"
    curl -s -L https://github.com/mikefarah/yq/releases/download/3.3.2/yq_linux_amd64 -o ${ROOT}/yq
    chmod +x yq
fi

yq() {
    $ROOT/yq $@
}

# . $ROOT/demo-setup-cli.sh
. $ROOT/demo-setup-discovery.sh