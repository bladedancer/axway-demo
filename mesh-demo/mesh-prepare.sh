#!/bin/bash

. ./env.sh

SECRET_NAME=$1
DOMAIN=${2:-mesh.example.com}

if [ -z $SECRET_NAME ]; then
  echo "Secret name required."
  exit -1
fi;

mkdir central

if [ -f "./certs/${DOMAIN}.key" ]; then
  cp ./certs/${DOMAIN}.key central/server.key
  cp ./certs/${DOMAIN}.crt central/server.crt
else
  ./generate-cert.sh ${DOMAIN}
fi

./generate-agent-keys.sh

echo =======================
echo Creating secrets
echo =======================
kubectl create namespace istio-system
kubectl create secret tls ${SECRET_NAME} -n istio-system --key central/server.key --cert central/server.crt
kubectl create namespace apic-control
kubectl create secret generic sda-secrets --namespace apic-control --from-file=publicKey=central/sda_public_key --from-file=privateKey=central/sda_private_key.pem --from-literal=password="" -o yaml
kubectl create secret generic csa-secrets --namespace apic-control --from-file=publicKey=central/csa_public_key --from-file=privateKey=central/csa_private_key.pem --from-literal=password="" -o yaml

echo =======================
echo Helm setup
echo =======================
helm repo add axway https://charts.axway.com/charts
helm repo update
