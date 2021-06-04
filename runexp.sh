#!/bin/sh
sleep 10

kind create cluster
kind get clusters
echo "Created kind cluster"
sleep 5

# kubectl cluster-info --context kind-kind
# echo "Set kubectl context"
kubectl apply -f https://raw.githubusercontent.com/iter8-tools/iter8-install/v0.5.1/core/build.yaml
echo "Installed iter8"

sleep 300