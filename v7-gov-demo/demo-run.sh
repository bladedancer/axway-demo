#!/bin/bash

ROOT=$(dirname ${BASH_SOURCE})

. $ROOT/../util.sh

backtotop

desc "Amplify Central Dataplane Governance Demo!"
desc "This script will launch the agents and install the project."

. env.sh

desc "Creating the environment"
run "vi project/environment.yaml"
run "amplify central --baseUrl=$AMPLIFY_URL apply -f project/environment.yaml"
desc "Show the environment in $AMPLIFY_URL/topology/environments/$ENVIRONMENT"

desc "Start the agents"
bgrun "xterm -e discovery/discovery_agent --pathConfig `pwd`/discovery"
bgrun "xterm -e governance/governance_agent --pathConfig `pwd`/governance/governance_agent.yml &"

desc "Configure the Backend API"
run "vi project/backend-api.yaml"
run "amplify central --baseUrl=$AMPLIFY_URL apply -f project/backend-api.yaml"
desc "Show the environment in $AMPLIFY_URL/topology/environments/$ENVIRONMENT"

desc "Configure the Virtual API"
run "amplify central --baseUrl=$AMPLIFY_URL apply -f project/container.yaml"
run "amplify central --baseUrl=$AMPLIFY_URL apply -f project/authrule.yaml"
run "amplify central --baseUrl=$AMPLIFY_URL apply -f project/credentials.yaml"
run "amplify central --baseUrl=$AMPLIFY_URL apply -f project/routing.yaml"
desc "Show the deployed API in https://$APIMANAGER_HOST:$APIMANAGER_PORT"