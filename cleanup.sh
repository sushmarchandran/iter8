docker rm -f iter8-ce
docker rm -f iter8-docker
docker rmi -f iter8-ce-image

docker volume rm iter8-docker-certs-ca iter8-docker-certs-client
docker network rm iter8-network

docker ps -a