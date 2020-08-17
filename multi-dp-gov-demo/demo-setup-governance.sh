#!/bin/bash

#backtotop

# Note download link is only good til October.
desc "Install the Governance Agent"
rm -rf governance && mkdir governance
run "curl -L 'https://dl.bintray.com/axway/generic-repo/governance_agent.zip?expiry=1601510400000&id=b3gu5gufhiVBSVYrMVJ6BClf8Jr6t9Yh8Y9%2BdCD1rVSbRjLZ%2FQ3rqxF0VTKAr6GCcxSwOx2CeHJRZC7zC7MdqgJXdyYUvzmLB%2FsFwr1amSA%3D&signature=MIjH1iN4W3y9LWuxlcH%2FuEgV6S8mcjlet71ZkwQmyraUxMuhhKajffuTNeHYWded4fS7fLC%2Bg6wVO1khAa5nOg%3D%3D' -o governance/governance_agent.zip"
run "unzip -d governance governance/governance_agent.zip"

desc "Configuring agent"
yq w -i $(dirname ${BASH_SOURCE})/governance/governance_agent.yml v7.basePath https://$APIMANAGER_HOST:$APIMANAGER_PORT/api/portal/v1.3
yq w -i $(dirname ${BASH_SOURCE})/governance/governance_agent.yml v7.auth.user $APIADMIN
yq w -i $(dirname ${BASH_SOURCE})/governance/governance_agent.yml v7.auth.pass $APIADMIN_PASSWORD
yq w -i $(dirname ${BASH_SOURCE})/governance/governance_agent.yml v7.ssl.insecureSkipVerify true
yq w -i $(dirname ${BASH_SOURCE})/governance/governance_agent.yml central.url $AMPLIFY_URL
yq w -i $(dirname ${BASH_SOURCE})/governance/governance_agent.yml central.tenantID $ORG_ID
yq w -i $(dirname ${BASH_SOURCE})/governance/governance_agent.yml central.teamID $TEAM_ID
yq w -i $(dirname ${BASH_SOURCE})/governance/governance_agent.yml central.environment $ENVIRONMENT
yq w -i $(dirname ${BASH_SOURCE})/governance/governance_agent.yml central.platformURL $PLATFORM_URL
yq w -i $(dirname ${BASH_SOURCE})/governance/governance_agent.yml central.auth.url $AUTH_URL
yq w -i $(dirname ${BASH_SOURCE})/governance/governance_agent.yml central.auth.clientID $DOSA
yq w -i $(dirname ${BASH_SOURCE})/governance/governance_agent.yml central.auth.privateKey $(realpath $DOSA_PRIV)
yq w -i $(dirname ${BASH_SOURCE})/governance/governance_agent.yml central.auth.publicKey $(realpath $DOSA_PUB)

show "$(dirname ${BASH_SOURCE})/governance/governance_agent.yml"
