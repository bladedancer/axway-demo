#!/bin/bash

ROOT=$(dirname ${BASH_SOURCE})

. $ROOT/../util.sh

backtotop

desc "Amplify Central Dataplane Governance Demo!"
desc "This script will launch the agents and install the project."

. env.sh
AMPLIFY_ARGS="--baseUrl=$AMPLIFY_URL"

desc "Creating the ${green}internal${blue} environment"
nowait_run "amplify central $AMPLIFY_ARGS apply -f project/internal/internal-env.yaml"
nowait_run "amplify central $AMPLIFY_ARGS apply -f project/internal/musical-instruments-api.yaml"
desc "Show the environment in $AMPLIFY_URL/topology/environments/internal"

desc "Creating the ${green}staging${blue} environments"
nowait_run "amplify central $AMPLIFY_ARGS apply -f project/staging/staging-env.yaml"
nowait_run "amplify central $AMPLIFY_ARGS apply -f project/staging/aws-dataplane/aws-env.yaml"
nowait_run "amplify central $AMPLIFY_ARGS apply -f project/staging/axway-dataplane/axway-env.yaml"
desc "Show the environments in $AMPLIFY_URL/topology/environments"

desc "Creating the virtual api"
show "project/virtual-api/routing.yaml"
nowait_run "amplify central $AMPLIFY_ARGS apply -f project/virtual-api/secret.yaml"
nowait_run "amplify central $AMPLIFY_ARGS apply -f project/virtual-api/virtualapi.yaml"
nowait_run "amplify central $AMPLIFY_ARGS apply -f project/virtual-api/authrule.yaml"
nowait_run "amplify central $AMPLIFY_ARGS apply -f project/virtual-api/corsrule.yaml"
nowait_run "amplify central $AMPLIFY_ARGS apply -f project/virtual-api/credentials.yaml"
nowait_run "amplify central $AMPLIFY_ARGS apply -f project/virtual-api/ratelimitrule.yaml"
nowait_run "amplify central $AMPLIFY_ARGS apply -f project/virtual-api/routing.yaml"

#desc "Start the agents"
#bgrun "xterm -e discovery/discovery_agent --pathConfig `pwd`/discovery"
#bgrun "xterm -e governance/governance_agent --v7 --pathConfig `pwd`/governance/governance_agent.yml"

desc "Deploy the Virtual API to Staging"
show "project/deployment.yaml"
nowait_run "amplify central $AMPLIFY_ARGS apply -f project/deployment.yaml"

desc "Show the deployed API in https://$APIMANAGER_HOST:$APIMANAGER_PORT"