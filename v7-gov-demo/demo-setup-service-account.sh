#!/bin/bash

desc "Creating agent service account"

SERVICEACCOUNT_NAME="Agent Account"
SERVICEACCOUNT_CONTENT="{\"serviceAccountName\":\"$SERVICEACCOUNT_NAME\",\"pemEncodedPublicKey\":\"$(cat $DOSA_PUB)\",\"serviceAccountType\":\"DOSA\",\"generateKeypair\":false}"

SERVICEACCOUNT_RESPONSE=$(curl -X POST -H "Authorization: $USER_ACCESS_TOKEN" -H "X-Axway-Tenant-Id: $ORG_ID" -H "Accept: application/json" -H "Content-Type: application/json" -d "$SERVICEACCOUNT_CONTENT" https://apicentral.axway.com/api/v1/serviceAccounts)

echo "$SERVICEACCOUNT_RESPONSE"

DOSA=$(echo $SERVICEACCOUNT_RESPONSE | jq -r .clientId)