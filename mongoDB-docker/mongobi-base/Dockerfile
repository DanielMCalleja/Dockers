ARG ROOT_CONTAINER=ubuntu:focal-20200423@sha256:5747316366b8cc9e3021cd7286f42b2d6d81e3d743e2ab571f55bcd5df788cc8
ARG BASE_CONTAINER=$ROOT_CONTAINER
FROM $BASE_CONTAINER

LABEL maintainer="daniel.mcalleja@outlook.com"

#Instalamos componentes.
RUN apt-get update && UBUNTU_FRONTEND=noninteractive apt-get install -y less --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common \
        net-tools \
        iproute2 \
        iputils-ping \
        gpg-agent \
        openssl \
        rsyslog \
        libssl-dev \
        libgssapi-krb5-2

#Limpiar APT cuando termine
RUN apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Creamos variables de entorno
ENV MONGOBI_HOME /opt/mongobi
ENV PATH=$PATH:$MONGOBI_HOME/bin

#Creamos directorio para mover los archivos
RUN mkdir -p /tmp

USER root

ENV MONGODB_BI_VER 2.13.4
ENV MONGODB_BI_URL https://info-mongodb-com.s3.amazonaws.com/mongodb-bi/v2/mongodb-bi-linux-x86_64-ubuntu1804-v2.13.4.tgz
ENV MONGODB_BI_SHA1 https://info-mongodb-com.s3.amazonaws.com/mongodb-bi/v2/mongodb-bi-linux-x86_64-ubuntu1804-v2.13.4.tgz.sha1


#Descargamos Mongodb-bi
RUN set -x && \
    curl -fsSL "$MONGODB_BI_URL" -o /tmp/mongodb-bi-$MONGODB_BI_VER.tgz && \
    #curl -fsSL "$MONGODB_BI_SHA1" -o /tmp/mongodb-bi-$MONGODB_BI_VER.sha1 && \
    #sha1sum -c /tmp/mongodb-bi-$MONGODB_BI_VER.sha1 /tmp/mongodb-bi-$MONGODB_BI_VER.tgz && \
    tar -xvzf /tmp/mongodb-bi-$MONGODB_BI_VER.tgz -C /tmp && \
    mv /tmp/mongodb-bi-linux-x86_64-ubuntu1804-v$MONGODB_BI_VER /opt/mongobi && \
    rm /tmp/mongodb-bi-$MONGODB_BI_VER.tgz*

#Damos permisos.
RUN chmod a+x /opt/mongobi/bin/mongosqld

#Copiamos run.sh
ADD run.sh /root/run.sh
RUN chmod a+x /root/run.sh

#Creamos volumen
VOLUME data/logs

#Exponer puertos
EXPOSE 3307


CMD ["/root/run.sh"]
