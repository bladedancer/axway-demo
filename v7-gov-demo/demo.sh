#!/bin/bash

ROOT=$(dirname ${BASH_SOURCE})

. $ROOT/../util.sh

DEMO_RUN_FAST=1

backtotop

desc "Welcome to Amplify Central Dataplane Governance Demo!"

if [ ! -f $ROOT/yq ]; then
    comment "Please wait getting some pre-requisites"
    curl -s -L https://github.com/mikefarah/yq/releases/download/3.3.2/yq_linux_amd64 -o ${ROOT}/yq
    chmod +x yq
fi

yq() {
    $ROOT/yq $@
}

. $ROOT/demo-setup-cli.sh
. $ROOT/demo-setup-env.sh

if [ -z $DOSA ]; then
    . $ROOT/demo-setup-service-account.sh    
fi

. $ROOT/demo-setup-discovery.sh