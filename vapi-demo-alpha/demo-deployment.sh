#!/bin/bash

. ../util.sh

backtotop

. ./demo-auth.sh

# Deployment
desc "Creating deployment"
show "apicentral/deployment-prod.yaml"
run "axway central apply -f apicentral/deployment-prod.yaml"

# Fake the state update
curl --location --request PUT 'https://gmatthews.dev.ampc.axwaytest.net/apis/management/v1alpha1/environments/prod/deployments/webhooksite-dep/state' \
--header "Authorization: Bearer $USER_ACCESS_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{
    "group": "management",
    "apiVersion": "v1alpha1",
    "kind": "Deployment",
    "name": "webhooksite-dep",
    "title": "webhooksite-dep",
    "tags": [
        "v1"
    ],
    "spec": {
        "virtualHost": "ampgw.theworkpc.com",
        "virtualAPIRelease": "webhooksite-1.0.0"
    },
    "state": {
        "name": "deployed",
        "message": "Deployed"
    }
}'


`xdg-open "https://webhook.site/#!/9cf934cd-89b6-4b20-b5d1-dd3d18d8105c"`
`xdg-open "https://gmatthews.dev.ampc.axwaytest.net/topology/environments/prod"`
