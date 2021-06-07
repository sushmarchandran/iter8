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
1.  Open the Code Engine console
2. Click on `Projects` on the side bar
3. Click on the `Create +` button to create a new prject
4. Name it `helloworld-project`

### Create application:

1. Open the Code Engine console.
2. Select Start creating from Run a container image.
3. Select Application.
4. Enter a name for the application: `sample-app`.
5. Select `helloworld-project` from the list of available projects.
4. Select to run a Container image and specify `docker.io/ibmcom/helloworld` for the image reference.
5. Click Create.
6. After the application status changes to Ready, you can test the application by clicking Send request in the Test pane. To open the application in a web page, click Open application URL.

### Apply candidate
```
kubectl apply -f $ITER8/samples/codeengine/sample-app-candidate.yaml
```

### Generate load
```
APPLICATION_URL=`kubectl get ksvc sample-app -o jsonpath='{.status.url}'`
curl $APPLICATION_URL

watch -n 0.5 'curl $APPLICATION_URL'
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
