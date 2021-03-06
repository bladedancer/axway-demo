#!/bin/bash

if [ -z "$(npm list -g | grep '@axway/amplify-cli@1.4.0')" ]; then
    desc "Let's first setup the client tools."
    run "npm install -g @axway/amplify-cli"
fi

if [ -z "$(amplify pm list | grep '@axway/amplify-central-cli')" ]; then
    desc "Install the Amplify Central module"
    run "amplify pm install @axway/amplify-central-cli"
fi
     