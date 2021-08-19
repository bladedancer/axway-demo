#!/bin/bash

. ../util.sh

backtotop

if [ -f .local ]; then
    say "Sourcing local config"
    . .local
fi

# DDNS UPDATE
if [ ! -z "${DDNSUSER}" ]; then
    DDNSHOST=${DDNSHOST-ampgw.theworkpc.com}
    say "Setting up DDNS for demo"
    IP=`curl -s ifconfig.me`
    say IP $IP
    say HOST $DDNSHOST
    `curl -s -u $DDNSUSER:$DDNSPASS \"https://api.dynu.com/nic/update?hostname=${DDNSHOST}&myip=${IP}&myipv6=no\"`
fi

# Login
. ./demo-auth.sh

# Cleanup
say "Cleaning up"
run "axway central delete -f apicentral/env-prod.yaml"
run "axway central delete -f apicentral/webhooksite/vapi.yaml"

# NEXT
. ./demo-env.sh