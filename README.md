[![Docker](https://img.shields.io/docker/cloud/build/eaudeweb/scratch?label=Docker&style=flat)](https://hub.docker.com/r/bsgrigorov/helm-operator/builds)
[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/helm-operator)](https://artifacthub.io/packages/search?repo=helm-operator)

# Helm Operator
Helm operator is a helm based operator using the [Operator SDK](https://sdk.operatorframework.io/docs/building-operators/helm/tutorial/).

The operator takes CRDs [crds](charts/templates/crds/) and charts from [helm-charts](helm-charts) and when a user creates a Custom Resource defined by the CRDs the operator deployes the corresponding helm chart.

## Installation
Make your code changes and create a PR. 

## Testing

### Using a test cluster
If adding new CRDs or charts in [helm-charts](helm-charts) make sure to build the new docker image and push it to harbor. 
```
docker-compose build
docker push bgrigorov/helm-operator:test
```

Setup your `KUBECONFIG` env var and install the helm-operator helm chart
```
helm upgrade -i helm-operator charts/ -f charts/values.test.yaml
```

### Local 
1. If you wish to run operator locally, install the [crds](charts/templates/crds/) manually
```
kubectl apply -f charts/templates/crds/
```

2. Set your `KUBECONFIG` env variable

3. Then you can run the operator with either `docker-compose up -d` or `make run`. 

### Testing the managed helm charts
Install the helm-chart managed by the operator
```
helm upgrade -i pgexp helm-charts/myexporter/ -f helm-charts/myexporter/values.test.yaml
```
Navigate to localhost:8080/metrics to see the exposed metrics. You can also connect to the mock DB that is running inside a sidecar container in the exporter pod and run some queries.

## Creating Custom Resources
```
kubectl apply -f samples/myexporter.yaml
kubectl get pgx
```

## Adding new CRDs
1. Define and add your CRD in [crds](charts/templates/crds/).
2. Add resources to [role](charts/templates/role.yaml).
3. Add the corresponding helm chart in [helm-charts](helm-charts). Make sure the names match.
4. Add a sample in [samples](samples).
5. Add watcher to [watches.yaml](watches.yaml).