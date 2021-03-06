#!/bin/bash

set -e

# create kind cluster
kind create cluster --wait 5m
kubectl cluster-info --context kind-kind

# platform setup
echo "Setting up platform"
$ITER8/samples/knative/quickstart/platformsetup.sh istio

# create app with live and dark versions
echo "Creating live and dark versions"
kubectl apply -f $ITER8/samples/knative/user-segmentation/services.yaml

# create routing rule
echo "Creating routing rule"
kubectl apply -f $ITER8/samples/knative/user-segmentation/routing-rule.yaml 

# Generate requests
echo "Generating requests"
TEMP_DIR=$(mktemp -d)
cd $TEMP_DIR
curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.8.2 sh -
istio-1.8.2/bin/istioctl kube-inject -f $ITER8/samples/knative/user-segmentation/curl.yaml | kubectl create -f -
cd $ITER8
    
# Create Iter8 experiment
echo "Creating the Iter8 metrics and experiment"
kubectl wait --for=condition=Ready ksvc/sample-app-v1
kubectl wait --for=condition=Ready ksvc/sample-app-v2
kubectl apply -f $ITER8/samples/knative/quickstart/metrics.yaml
kubectl apply -f $ITER8/samples/knative/user-segmentation/experiment.yaml        

# Sleep
echo "Sleep for 150s"
sleep 150.0

# Check
source  $ITER8/samples/knative/user-segmentation/check.sh

# Cleanup .. not needed since cluster is getting deleted; just forming a good habit!
kubectl delete -f $ITER8/samples/knative/user-segmentation/experiment.yaml
kubectl delete -f $ITER8/samples/knative/user-segmentation/curl.yaml
kubectl delete -f $ITER8/samples/knative/user-segmentation/routing-rule.yaml
kubectl delete -f $ITER8/samples/knative/user-segmentation/services.yaml

# delete kind cluster
kind delete cluster

set +e