#!/bin/bash

. ./env.sh

ROOT=$(dirname ${BASH_SOURCE})
OVERRIDE=$1

if [ -z $OVERRIDE ]; then
  echo "Override zipfile required."
  exit -1
fi;

if [ ! -f $OVERRIDE ]; then
  echo "Override zipfile not found: $OVERRIDE"
  exit -1
fi;

#
# Run with AWS vault to allow for update of helm repos using MFA and s3.
#
if [ -z $AWS_SESSION_TOKEN ]; then
    if [ ! -z $AWS_VAULT_PROFILE ]; then
        if [ ! command -v aws-vault &> /dev/null ]; then
            echo "You need to install aws-vault"
            exit 1
        else 
            aws-vault exec $AWS_VAULT_PROFILE $0 $@
            exit
        fi
    fi
fi

#
# Setup the k3d cluster
#
. $ROOT/create-cluster.sh

echo =======================
echo Expand override
echo =======================
rm -rf override
mkdir override
unzip -d override $OVERRIDE

SECRET_NAME=$(grep secretName override/istioOverride.yaml | awk '{print $2}')
DOMAIN=$(grep external-dns.alpha.kubernetes.io/hostname override/istioOverride.yaml | awk '{print $2}'  | sed 's/.$//g')

#
# Prepare the mesh
#
$ROOT/mesh-prepare.sh ${SECRET_NAME} ${DOMAIN}



echo =======================
echo Installing Istio
echo =======================
./istio.sh

echo =======================
echo Installing Agents
echo =======================
helm upgrade --install --namespace apic-control apic-hybrid axway/apicentral-hybrid -f ./override/hybridOverride.yaml --set als.enabled=true

kubectl get services -n apic-control
kubectl get services -n apic-demo
