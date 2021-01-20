#!/bin/bash

. ./env.sh

echo ======================
echo === Create Cluster ===
echo ======================
k3d cluster delete $CLUSTER
k3d cluster create --no-lb --wait -i docker.io/rancher/k3s:$K8S_IMAGE $CLUSTER
export KUBECONFIG=$(k3d kubeconfig write $CLUSTER)
kubectl cluster-info

echo ================================
echo ===    Copying in Images     ===
echo ================================
docker pull bladedancer/api-builder-demo-services:news-service
docker pull bladedancer/api-builder-demo-services:weather-service
docker pull bladedancer/api-builder-demo-services:user-news-and-weather
k3d image import -c $CLUSTER bladedancer/api-builder-demo-services:news-service
k3d image import -c $CLUSTER bladedancer/api-builder-demo-services:weather-service
k3d image import -c $CLUSTER bladedancer/api-builder-demo-services:user-news-and-weather
