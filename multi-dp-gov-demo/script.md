Pre-requisites
--------------


Script
------

1) Ground rules

- Forward looking statements
- POC
- Questions anytime.

2) Set the stage
- Explain Amplify Centrals Control Tower. 
- Explain declarative configuration. Similar to k8s. Declare the desired state of the system. Up to central to reconcile the state and reach eventual consistency.
- Configure once deploy anywhere mantra - cross instances of the same gateway or cross gateways.

3) Demo 

- Explain the outcome of the project
Musical instruments secured through two different API Gateways by two different vendors (AWS, Axway) using the same policy.

- Show API Manager & AWS
https://localhost:8075
https://axway-ampc-sandbox.signin.aws.amazon.com/console / TODO ADD DIRECT LINK

- Show the source project
In vscode

- Show the environments
https://gamma.sandbox.ampc.axwaytest.net/topology/environments

- Show the Path route
In vscode

- Explain "onboarding"
Discovery (or in this case declaration) of gateway type and supported policies. 
Forward looking - discovery of backends, functions, services, etc

- Deep dive into Authorizers
Side by side of lambda & policy

- Deep dive into cors
Show files, show cors.

- Risk it all and deploy ??? Github OAS?

