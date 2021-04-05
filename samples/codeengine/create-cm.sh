
kubeconfig=$1

kubectl delete configmap kubeconfig -n iter8-system
cp ${kubeconfig} /tmp/ce-kubeconfig.yaml
kubectl create configmap kubeconfig -n iter8-system --from-file /tmp/ce-kubeconfig.yaml


rm /tmp/ce-kubeconfig.yaml