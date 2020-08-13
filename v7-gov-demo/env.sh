#!/bin/bash

# Platform: dev, preprod, staging, prod
PLATFORM_ENV=staging 
PLATFORM_URL=https://platform.axwaytest.net
AUTH_URL=https://login-preprod.axway.com/auth

# Amplify Central
ENVIRONMENT="DemoEnv"
AMPLIFY_URL=https://gmatthews.dev.ampc.axwaytest.net

# If DOSA is not set a new service account will be created
DOSA=
DOSA_PRIV=./private_key.pem
DOSA_PUB=./public_key.pem

# Credentials for API Manager
APIADMIN=apiadmin
APIADMIN_PASSWORD=ChangeMe

# Details for the authenticated user - will be extracted from session
ORG_ID=
TEAM="Default Team (Central)"
TEAM_ID=

# Script control
DEMO_RUN_FAST=1
