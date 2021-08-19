#!/bin/bash

. ../util.sh

backtotop

. ./demo-auth.sh

# Environment
desc "Creating environment"
show "apicentral/env-prod.yaml"
run "axway central apply -f apicentral/env-prod.yaml"

desc "GO RESTART AGENTS"

# NEXT
. ./demo-vapi.sh