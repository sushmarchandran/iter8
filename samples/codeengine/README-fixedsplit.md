# Iter8-code engine demo instructions
This demo requires two kubernetes clusters. One IBM Cloud cluster with a code-engine plugin installed and a local minikube cluster

## Preliminary set up:


## In IBM Cloud Cluster:
### Step 1: Sign into IBM Cloud and set up resource group and project. Save the Kubeconfig path generated in the last step.
```
ic login --sso
ic target -g default
ibmcloud ce project select -n sample-p
ibmcloud ce project current 
```

### Step 2: Get ns
```
kubectl get ns
export NAMESPACE=<Code engine namespace>
```

## In your local minikube cluster:
### Step 1: Start minikube
```
minikube start --cpus 5 --memory 5120
```

### Step 3: Set PATHS to run cmmands easily
```
export ITER8=/Users/sushma/projects/iter8-tools/forks/iter8
export ITER8INSTALL=/Users/sushma/projects/iter8-tools/forks/iter8-install
```

### Step 4: Install ITER8
```
kustomize build $ITER8INSTALL/core | kubectl -n iter8-system apply -f - 
```

### Step 5: Create a configmap so the kubeconfig of the code engine cluster is accessible to minikube. Get 
```
$ITER8/samples/codeengine/create-cm.sh <CODE ENGINE KUBECONFIG>
```

### Step 6: Run metrics mock
```
kubectl apply -f $ITER8/samples/codeengine/metricmock.yaml 
```

### Step 7: Apply Metrics
```
kustomize build $ITER8INSTALL/metrics/codeengine | kubectl apply -f - 
```

------------------------------------------------
## Demo of a fixed split experiment using iter8

### Apply the candidate version in the Code Engine cluster
```
kubectl apply -f samples/codeengine/sample-app-candidate.yaml -n $NAMESPACE
```

### Show traffic
```
http://sample-app.7roueeh7gob.us-south.codeengine.appdomain.cloud
```

### Run experiment
```
kubectl apply -f $ITER8/samples/codeengine/experiment.yaml
```


### Watch experiment:
```
kubectl get experiment -ojson --watch | jq .status.analysis.versionAssessments 
```


###############################
## On minikube, install iter8

Run:

```
kubectl apply -f $ITER8/samples/codeengine/prometheus/clusterrole.yaml

kubectl create clusterrolebinding prometheus-querier --clusterrole=prometheus-querier --serviceaccount=kube-system:prometheus


```