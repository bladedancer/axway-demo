#!/bin/bash

ROOT=$(dirname ${BASH_SOURCE})

. $ROOT/../util.sh

yq() {
    $ROOT/yq $@
}


backtotop

. env.sh
AMPLIFY_ARGS="--baseUrl=$AMPLIFY_URL"

desc "Amplify Central Dataplane Governance Demo!"
desc "This script will deploy the Sunrise API to v7."

# Update the tokens
yq w -i $(dirname ${BASH_SOURCE})/governance/governance_agent.yml aws.auth.accesskey $AWS_ACCESS_KEY_ID
yq w -i $(dirname ${BASH_SOURCE})/governance/governance_agent.yml aws.auth.secretkey $AWS_SECRET_ACCESS_KEY
yq w -i $(dirname ${BASH_SOURCE})/governance/governance_agent.yml aws.auth.sessionToken "$AWS_SECURITY_TOKEN"

desc "Start the agents"
bgrun "xterm -e discovery/discovery_agent --pathConfig `pwd`/discovery --centralEnvironment $AXWAY_DATAPLANE"
bgrun "xterm -e governance/governance_agent --v7 --pathConfig `pwd`/governance/governance_agent.yml --centralEnvironment $AXWAY_DATAPLANE"


desc "Creating the ${green}internal${blue} service"
run "amplify central $AMPLIFY_ARGS apply -f project/live/petstore-internal.yaml"

desc "Creating the ${green}governance rules${blue}"
run "amplify central $AMPLIFY_ARGS apply -f project/live/petstore-proxy.yaml"

desc "Show the deployed API"