#!/bin/bash

ROOT=$(dirname ${BASH_SOURCE})

. $ROOT/../util.sh

backtotop

desc "Amplify Central Dataplane Governance Demo!"
desc "This script clean up the demo."

. env.sh
AMPLIFY_ARGS="--baseUrl=$AMPLIFY_URL"

desc "Deleting the environments"
nowait_run "amplify central $AMPLIFY_ARGS delete -f project/internal/internal-env.yaml"
nowait_run "amplify central $AMPLIFY_ARGS delete -f project/staging/staging-env.yaml"
nowait_run "amplify central $AMPLIFY_ARGS delete -f project/staging/aws-dataplane/aws-env.yaml"
nowait_run "amplify central $AMPLIFY_ARGS delete -f project/staging/axway-dataplane/axway-env.yaml"
