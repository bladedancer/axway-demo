#!/bin/bash

#backtotop

desc "Install the Discovery Agent"
rm -rf discovery && mkdir discovery
run "curl -L https://axway.bintray.com/generic-repo/v7-agents/v7_discovery_agent/latest/discovery_agent-latest.zip -o discovery/discovery_agent-latest.zip"
run "unzip -d discovery discovery/discovery_agent-latest.zip"

desc "Configuring agent"
yq w -i $(dirname ${BASH_SOURCE})/discovery/discovery_agent.yml apimanager.auth.username $APIADMIN
yq w -i $(dirname ${BASH_SOURCE})/discovery/discovery_agent.yml apimanager.auth.password $APIADMIN_PASSWORD
yq w -i $(dirname ${BASH_SOURCE})/discovery/discovery_agent.yml central.tenantID $ORG_ID
yq w -i $(dirname ${BASH_SOURCE})/discovery/discovery_agent.yml central.teamID $TEAM_ID
yq w -i $(dirname ${BASH_SOURCE})/discovery/discovery_agent.yml central.environment $ENVIRONMENT
yq w -i $(dirname ${BASH_SOURCE})/discovery/discovery_agent.yml central.auth.clientId $DOSA
yq w -i $(dirname ${BASH_SOURCE})/discovery/discovery_agent.yml central.auth.privateKey $DOSA_PRIV
yq w -i $(dirname ${BASH_SOURCE})/discovery/discovery_agent.yml central.auth.publicKey $DOSA_PUB

run "vi $(dirname ${BASH_SOURCE})/discovery/discovery_agent.yml"