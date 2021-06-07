#!/bin/sh
# Arguments
# $1: Kubeconfig of the code engine cluster
# $2: Experiment file name
set -e 

# Ensure ITER8 environment variable is set
if [[ -z ${ITER8} ]]; then
    echo "ITER8 environment variable needs to be set to the root folder of Iter8"
    exit 1
else
    echo "ITER8 is set to " $ITER8
fi


# Start minikube
minikube start --cpus 5 --memory 5120

# Install ITER8 
# TODO: Change to install from github
kustomize build $ITER8INSTALL/core | kubectl -n iter8-system apply -f - 

# Create a configmap so the kubeconfig of the code engine cluster is accessible to minikube.
$ITER8/samples/codeengine/create-cm.sh "$1"

# Create experiment
kubectl apply -f $ITER8/samples/codeengine/"$2"


