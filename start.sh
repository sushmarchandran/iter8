#!/bin/sh
# Do this only if network/volume doesn't exist:
docker network create iter8-network
docker volume create iter8-docker-certs-ca
docker volume create iter8-docker-certs-client

docker run --privileged --name iter8-docker -d \
    --network iter8-network --network-alias docker \
    -e DOCKER_TLS_CERTDIR=/certs \
    -v iter8-docker-certs-ca:/certs/ca \
    -v iter8-docker-certs-client:/certs/client \
    docker:dind
echo "CREATED DOCKER:DIND CONTAINER"

docker build -t iter8-ce-image .

docker run --privileged --name iter8-ce \
  --network iter8-network -e DOCKER_TLS_CERTDIR=/certs \
  -v iter8-docker-certs-client:/certs/client:ro \
  iter8-ce-image

# docker run -d --privileged --name iter8-ce \
#  --network iter8-network -e DOCKER_TLS_CERTDIR=/certs \
#   -v iter8-docker-certs-client:/certs/client:ro \
#   iter8-ce-image

echo "CREATED ITER8 DOCKER CONTAINER"
# sleep 10

# docker exec -it iter8-ce kind create cluster

# echo "CREATED KIND CLUSTER"
# docker exec -it iter8-ce kubectl cluster-info --context kind-kind
# echo "KUBECTL CONTEXT  SET TO KIND"

# docker exec -it iter8-ce kubectl apply -f https://raw.githubusercontent.com/iter8-tools/iter8-install/v0.5.1/core/build.yaml

# Wait for iter8 pods to run


