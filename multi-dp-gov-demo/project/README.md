# Amplify Central Governance Demo

## internal

| File | Description |
| --- | ---|
| internal-env.yaml | Environment for internal services that are not proxied by the gateway. |
| musical-instruments-api.yaml | Musical Instruments service running on ARS. |

## staging

These are the environments bound to a physical dataplane representing a staging environment.

### aws-dataplane

| File | Description |
| --- | ---|
| aws-env.yaml | Environment for AWS API Gateway staging environment. |

### axway-dataplane

| File | Description |
| --- | ---|
| axway-env.yaml | Environment for Axway API Manager staging environment. |
