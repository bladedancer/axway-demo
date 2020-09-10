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

desc "API Manager:     https://$APIMANAGER_HOST:$APIMANAGER_PORT"
desc "Amplify Central: $AMPLIFY_URL"