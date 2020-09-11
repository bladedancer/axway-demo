#!/bin/bash

. ./env.sh 

if [ ! -d istio-$ISTIO_VERSION ]; then
  curl -L https://istio.io/downloadIstio | ISTIO_VERSION=$ISTIO_VERSION sh -
fi
export PATH=$PWD/istio-$ISTIO_VERSION/bin:$PATH

istioctl install --set profile=demo -f override/istioOverride.yaml


echo =======================
echo Kiali Secret- demo:password
echo =======================
cat <<EOF | kubectl -n istio-system apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: kiali
  namespace: $NAMESPACE
  labels:
    app: kiali
type: Opaque
data:
  passphrase: cGFzc3dvcmQ=
  username: ZGVtbw==
EOF