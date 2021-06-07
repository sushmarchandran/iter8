# Iter8-code engine demo instructions
This demo requires two kubernetes clusters. One IBM Cloud cluster with a code-engine plugin installed and a local minikube cluster

## Preliminary set up:


## In IBM Cloud Cluster:
### Sign into IBM Cloud and set up resource group and project. Save the Kubeconfig path generated in the last step.
```
ic login --sso
ic target -g default
ibmcloud ce project select -n helloworld-project
ibmcloud ce project current 
```

### Create project and baseline application

### Apply candidate


### Generate load
```
curl http://sample-app.7roueeh7gob.us-south.codeengine.appdomain.cloud

watch -n 0.5 'curl https://sample-app.7roueeh7gob.us-south.codeengine.appdomain.cloud/'
```

## In a separate terminal, run a script to create a local Kubernetes cluster, install Iter8 and start  an Iter8 experiment:
```
$ITER8/samples/codeengine/runexp.sh <kubeconfig-of-codeengine-exp> <experiment-file-name>
```

<!-- ### Start minikube
```
minikube start --cpus 5 --memory 5120
```

### Set PATHS to run cmmands easily
```
export ITER8=/Users/sushma/projects/iter8-tools/forks/iter8
export ITER8INSTALL=/Users/sushma/projects/iter8-tools/forks/iter8-install
```

### Install ITER8
```
kustomize build $ITER8INSTALL/core | kubectl -n iter8-system apply -f - 
```

### Create a configmap so the kubeconfig of the code engine cluster is accessible to minikube.
```
$ITER8/samples/codeengine/create-cm.sh <CODE ENGINE KUBECONFIG>
```

### Apply Metrics
```
kubectl apply -f $ITER8INSTALL/metrics/codeengine/metrics/mean-latency.yaml -n iter8-system
kubectl apply -f $ITER8INSTALL/metrics/codeengine/metrics/request-count.yaml -n iter8-system
kubectl apply -f $ITER8INSTALL/metrics/codeengine/metrics/error-rate.yaml -n iter8-system
```

------------------------------------------------
## Demo of a Conformance experiment using iter8


### Run experiment
```
kubectl apply -f $ITER8/samples/codeengine/conformance-exp.yaml
``` -->


### Watch experiment:
```
kubectl get experiment -ojson --watch | jq .status.analysis.versionAssessments 
```
