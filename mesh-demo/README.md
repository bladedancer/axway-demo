# Mesh Demo

The demo creates an K8s cluster in K3d, installs an Istio service mesh and connects it to Amplify Central dataplane.

## Usage

    ./setup.sh <overrideFile.zip>
    export KUBECONFIG=$(k3d kubeconfig write democluster)