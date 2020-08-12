#!/bin/bash

. $(dirname ${BASH_SOURCE})/../util.sh

SOURCE_DIR=$PWD

backtotop

desc "Welcome to Amplify Central Dataplane Governance Demo!"
desc "Let's first setup the client tools."
run "npm install -g @axway/amplify-cli"

desc "Install the Amplify Central module"
run "amplify pm install @axway/amplify-central-cli"

desc "Login - Browser prompt"
run "amplify config set auth.tokenStoreType file"
run "amplify auth logout -a"
run "amplify auth login --client-id apicentral"

AUTH_RESPONSE=$(amplify auth login --client-id apicentral --json)
USER_ACCESS_TOKEN=$(echo $AUTH_RESPONSE | jq .tokens.access_token)
ORG_ID=$(echo $AUTH_RESPONSE | jq .org.org_id)
