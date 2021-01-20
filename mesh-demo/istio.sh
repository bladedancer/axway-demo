#!/bin/bash

. ./env.sh 

if [ ! -d istio-$ISTIO_VERSION ]; then
  curl -L https://istio.io/downloadIstio | ISTIO_VERSION=$ISTIO_VERSION sh -
fi
export PATH=$PWD/istio-$ISTIO_VERSION/bin:$PATH

istioctl install --set profile=demo -f override/istioOverride.yaml
