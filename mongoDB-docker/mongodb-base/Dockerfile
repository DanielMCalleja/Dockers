ARG ROOT_CONTAINER=ubuntu:focal-20200423@sha256:5747316366b8cc9e3021cd7286f42b2d6d81e3d743e2ab571f55bcd5df788cc8
ARG BASE_CONTAINER=$ROOT_CONTAINER
FROM $BASE_CONTAINER

LABEL maintainer="daniel.mcalleja@outlook.com"

#Instalamos wget, openjdk-8-jdk, openssh-server y net-tools
RUN apt-get update && UBUNTU_FRONTEND=noninteractive apt-get install -y less --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        curl \
        wget \
        software-properties-common \
        openjdk-8-jdk \
        net-tools \
        iproute2 \
        iputils-ping \
        gpg-agent \
        nano

#Limpiar APT cuando termine
RUN apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Creamos variables de entorno
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV MONGODB_VERSION 4.2
ENV MONGODB_ASC_URL https://www.mongodb.org/static/pgp/server-4.2.asc

#Creamos directorio para mover los archivos
RUN mkdir -p /tmp

USER root

RUN curl -fsSL "$MONGODB_ASC_URL" -o /tmp/mongodb-$MONGODB_VERSION.asc && \
    apt-key add /tmp/mongodb-$MONGODB_VERSION.asc && \
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu \ 
    bionic/mongodb-org/4.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list && \
    apt-get update && \
    apt-get install -y mongodb-org

VOLUME data/db

ADD run.sh /root/run.sh
RUN chmod a+x /root/run.sh

#Exponer puertos
EXPOSE 27017 27018 27019

CMD ["/root/run.sh"]






