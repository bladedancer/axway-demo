#!/bin/bash

desc "Perform Authentication"
run "amplify config set --no-banner auth.tokenStoreType file"
run "amplify auth logout -a --no-banner"
run "amplify auth login --no-banner --env $PLATFORM_ENV --client-id apicentral"

# Populate Env
desc "Setting up environment"

AUTH_RESPONSE=$(amplify auth login --env $PLATFORM_ENV --client-id apicentral --json)
USER_ACCESS_TOKEN=$(echo $AUTH_RESPONSE | jq -r .tokens.access_token)
SESSION=$(curl -s -H "Authorization: Bearer $USER_ACCESS_TOKEN" $PLATFORM_URL/api/v1/auth/findSession)

ORG_ID=$(echo $AUTH_RESPONSE | jq .org.org_id)

TEAM_RESPONSE=$(curl -s -G -H "Authorization: Bearer $USER_ACCESS_TOKEN" -H "X-Axway-Tenant-Id: $ORG_ID" $AMPLIFY_URL/api/v1/teams --data-urlencode "query=name==\"$TEAM\"")
TEAM_ID=$(echo $TEAM_RESPONSE | jq -r ".[0].id")

desc "\nORG_ID=$ORG_ID\nTEAM_ID=$TEAM_ID"
