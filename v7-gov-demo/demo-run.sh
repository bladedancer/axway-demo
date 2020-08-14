#!/bin/bash

ROOT=$(dirname ${BASH_SOURCE})

. $ROOT/../util.sh

backtotop

desc "Amplify Central Dataplane Governance Demo!"
desc "This script will launch the agents and install the project."

. env.sh

desc "Creating the environment"
show "project/environment.yaml"
run "amplify central --baseUrl=$AMPLIFY_URL apply -f project/environment.yaml"
desc "Show the environment in $AMPLIFY_URL/topology/environments/$ENVIRONMENT"

desc "Start the agents"
bgrun "xterm -e discovery/discovery_agent --pathConfig `pwd`/discovery"
bgrun "xterm -e governance/governance_agent --v7 --pathConfig `pwd`/governance/governance_agent.yml"

desc "Configure the Backend API"
show "project/backend-api.yaml"
run "amplify central --baseUrl=$AMPLIFY_URL apply -f project/backend-api.yaml"
desc "Show the environment in $AMPLIFY_URL/topology/environments/$ENVIRONMENT"

desc "Configure the Virtual API"
run "amplify central --baseUrl=$AMPLIFY_URL apply -f project/virtual-api/container.yaml"
run "amplify central --baseUrl=$AMPLIFY_URL apply -f project/virtual-api/authrule.yaml"
run "amplify central --baseUrl=$AMPLIFY_URL apply -f project/virtual-api/credentials.yaml"
run "amplify central --baseUrl=$AMPLIFY_URL apply -f project/virtual-api/routing.yaml"

desc "Deploy the Virtual API to API Manager"
show "project/deployment.yaml"
run "amplify central --baseUrl=$AMPLIFY_URL apply -f project/deployment.yaml"

desc "Show the deployed API in https://$APIMANAGER_HOST:$APIMANAGER_PORT"