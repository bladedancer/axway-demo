#!/bin/bash

. ../util.sh

backtotop

. ./demo-auth.sh

# VAPI
desc "Creating virtual api"
show "apicentral/webhooksite/vapi.yaml"
run "axway central apply -f apicentral/webhooksite/vapi.yaml"

# Virtual Service
desc "Creating virtual service"
show "apicentral/webhooksite/virtualservice.yaml"
run "axway central apply -f apicentral/webhooksite/virtualservice.yaml"

# OAS 
desc "Creating api spec"
show "apicentral/webhooksite/oas3document.yaml"
run "axway central apply -f apicentral/webhooksite/oas3document.yaml"

# Release
desc "Creating Virtual API Release by creating tag."
show "apicentral/webhooksite/tag.yaml"
run "axway central apply -f apicentral/webhooksite/tag.yaml"

desc "Resources created in Central."
run "axway central get virtualapi,virtualapireleases,virtualservices,oas3documents,releasetags"

# NEXT
. ./demo-deployment.sh

# Postman & API Server