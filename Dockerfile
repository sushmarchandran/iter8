# FROM ubuntu:18.04
# RUN apt-get update
# RUN apt-get install -y --no-install-recommends build-essential gcc

# RUN apt-get install -y curl
FROM docker:latest

RUN apk update
RUN apk upgrade
RUN apk add curl

RUN curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.11.0/kind-linux-amd64
RUN chmod +x ./kind
RUN mv ./kind /bin/kind

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN mv kubectl /bin/
RUN chmod 755 /bin/kubectl

RUN mkdir /ind
COPY runexp.sh ./ind/runexp.sh
RUN chmod a+x ./ind/runexp.sh
CMD ["./ind/runexp.sh"]