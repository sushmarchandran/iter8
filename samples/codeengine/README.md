# Iter8-code engine instructions


## Sign into IBM Cloud and set up resource group and project with access t the kubeconfig
```
ic login --sso
ic target -g default
ibmcloud ce project select -n sample-p
ibmcloud ce project current 
```

## Get ns
```
kubectl get ns
```

## Add the namespace into the candidate script

## Apply the candidate version for that
```
kubectl apply -f samples/codeengine/sample-app-candidate.yaml -n <NAMESPACE>
```


## Install ITER8

```
kustomize build ./core | kubectl -n iter8-system apply -f - 
```


## Create kube config
./samples/codeengine/create-cm.sh /Users/sushma/.bluemix/plugins/code-engine/sample-p-72127f4a-ea5b-4c6f-a64a-054bcb081958.yaml



## Run metrics mock
```
kubectl apply -f samples/codeengine/metricmock.yaml 
```

## Apply Metrics
```
kustomize build ./metrics | kubectl apply -f - 
```


## Generate traffic


## Run experiment
