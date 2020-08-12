#!/bin/bash

. $(dirname ${BASH_SOURCE})/../util.sh

SOURCE_DIR=$PWD

backtotop

desc "Install the Discovery Agent"
rm -rf discovery && mkdir discovery
run "curl -L https://axway.bintray.com/generic-repo/v7-agents/v7_discovery_agent/latest/discovery_agent-latest.zip -o discovery/discovery_agent-latest.zip"
run "unzip -d discovery discovery/discovery_agent-latest.zip"

# Populate yaml
yq w -i $(dirname ${BASH_SOURCE})/discovery/discovery_agent.yml apimanager.auth.username apiadmin
yq w -i $(dirname ${BASH_SOURCE})/discovery/discovery_agent.yml apimanager.auth.password ChangeMe
 