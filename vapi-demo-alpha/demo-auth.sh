#!/bin/bash

. ../util.sh

if [ -z "$AUTHONCE" ]; then
    say "Axway Login"
    prompt
    AUTH_RESPONSE=$(axway auth login --json)
    USER_ACCESS_TOKEN=$(echo $AUTH_RESPONSE | jq -r .auth.tokens.access_token)
    AUTHONCE=1
fi