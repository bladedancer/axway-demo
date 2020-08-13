#!/bin/bash

#TEAM="AMPLIFY Developer"
ENVIRONMENT=DemoEnv
DOSA=
DOSA_PRIV=./private_key.pem
DOSA_PUB=./public_key.pem
APIADMIN=apiadmin
APIADMIN_PASSWORD=ChangeMe

#backtotop

#if [ -z "$(amplify auth ls --no-banner | grep 'login.axway.com')" ]; then
    desc "Perform Authentication"
    run "amplify config set --no-banner auth.tokenStoreType file"
    run "amplify auth logout -a --no-banner"
    run "amplify auth login --no-banner --client-id apicentral"
#fi

# Populate Env
comment "Setting up environment"

AUTH_RESPONSE=$(amplify auth login --client-id apicentral --json)
USER_ACCESS_TOKEN=$(echo $AUTH_RESPONSE | jq -r .tokens.access_token)
SESSION=$(curl -s -H "Authorization: Bearer $USER_ACCESS_TOKEN" https://platform.axway.com/api/v1/auth/findSession)

ORG_ID=$(echo $AUTH_RESPONSE | jq .org.org_id)
#TEAM_ID=$(echo $SESSION | jq -r ".result.teams[] | select (.name==\"$TEAM\").guid")
TEAM_ID=
