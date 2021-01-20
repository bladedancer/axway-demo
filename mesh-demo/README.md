# Mesh Demo

The demo creates an K8s cluster in K3d, installs an Istio service mesh and connects it to Amplify Central dataplane.

## Usage

    ./setup.sh <overrideFile.zip>
    export KUBECONFIG=$(k3d kubeconfig write democluster)

## Adding the Demo

```
kubectl create namespace demo
kubectl label namespace demo istio-injection=enabled
helm install --namespace demo --name brief  https://github.com/bladedancer/Hybrid/blob/master/meshdemo/helm/user-news-and-weather-1.0.0.tgz?raw=true --set news.backendKey=<you newsapi key> --set weather.backendKey=<your openweather key> 
```

Note you need to get the API Key for the News and Weather API backends from https://newsapi.org and https://openweathermap.org respectively. 

### Configuring governance

In API Central expose the `user-news-and-weather` service as a proxy. Deploy the proxy to the mesh.
Add the following as egress policies:

newsapi.org:443
api.openweathermap.org:443


### Testing

#### Registration
```
curl -v --location --request POST '<mesh ur>/<basepath>/register' \
--user mykey: \
--header 'Content-Type: application/json' \
--data-raw '{
    "uid": "fred",
    "city": "Dublin",
    "country": "IE",
    "interest": "Technology"
}'
```

e.g.
```
curl --insecure --location --request POST 'https://meshdemo.apicentral-hybrid.axwaytest.net:443/api/unw-brief/register' \
--user mykey: \
--header 'Content-Type: application/json' \
--data-raw '{
    "uid": "fred",
    "city": "Dublin",
    "country": "IE",
    "interest": "Technology"
}'
```

#### Info
```
curl --location --user mykey: --request GET '<mesh ur>/<basepath>/<uid>/info'
```

e.g.
```
curl --insecure --location --user mykey: --request GET 'https://meshdemo.apicentral-hybrid.axwaytest.net:443/api/unw-brief/fred/info'
```


## Kiali

Install Kiali (had issues with the Istio built in support so manually install for now).

```
helm install \
  --namespace istio-system \
  --set auth.strategy="anonymous" \
  --repo https://kiali.org/helm-charts \
  kiali-server \
  kiali-server
```

Port forward it is the simplest option:

```
kubectl -n istio-system port-forward svc/kiali 20001
```

And open the console:
```
https://localhost:20001/
```

## Prometheus
kubectl -n istio-system port-forward --address 0.0.0.0 svc/prometheus 9090

## Jaeger
kubectl -n istio-system port-forward --address 0.0.0.0 svc/tracing 18080:80