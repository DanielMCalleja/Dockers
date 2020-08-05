ARG ROOT_CONTAINER=ubuntu:focal-20200423@sha256:5747316366b8cc9e3021cd7286f42b2d6d81e3d743e2ab571f55bcd5df788cc8
ARG BASE_CONTAINER=$ROOT_CONTAINER
FROM $BASE_CONTAINER

LABEL maintainer="daniel.mcalleja@outlook.com"

#Instalamos wget, openjdk-8-jdk, openssh-server y net-tools
RUN  apt-get update && UBUNTU_FRONTEND=noninteractive \
     apt-get install -y less --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        curl \
        wget \
        software-properties-common \
        openjdk-8-jdk \
	python \
	net-tools \
        iproute2 \
	iputils-ping \
        gpg-agent \
	nano
    

#Limpiar APT cuando termine
RUN apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Creamos directorio para mover los archivos
RUN mkdir -p /tmp

#Declaramos variables para instalación
ENV SPARK_VERSION 2.4.5
ENV SPARK_URL https://downloads.apache.org/spark/spark-2.4.5/spark-2.4.5-bin-hadoop2.7.tgz
ENV SPARK_ASC_URL https://downloads.apache.org/spark/spark-2.4.5/spark-2.4.5-bin-hadoop2.7.tgz.asc

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
ENV SPARK_HOME=/opt/spark
ENV PATH=$PATH:$JAVA_HOME/bin:$SPARK_HOME/bin
USER root

RUN wget https://dist.apache.org/repos/dist/release/spark/KEYS
RUN gpg --import KEYS

RUN set -x && \
    curl -fsSL "$SPARK_URL" -o /tmp/spark-$SPARK_VERSION.tgz && \
    curl -fsSL "$SPARK_ASC_URL" -o /tmp/spark-$SPARK_VERSION.tgz.asc && \
    gpg --verify /tmp/spark-$SPARK_VERSION.tgz.asc /tmp/spark-$SPARK_VERSION.tgz && \
    gpg --print-md SHA256 /tmp/spark-$SPARK_VERSION.tgz && \
    tar -xvf /tmp/spark-$SPARK_VERSION.tgz -C /tmp && \
    mv /tmp/spark-$SPARK_VERSION-bin-hadoop2.7 /opt/spark && \
    rm /tmp/spark-$SPARK_VERSION.tgz*

#Copiamos archivos de configuracion
COPY ./jars/*.jar $SPARK_HOME/jars/

#Creamos el fichero log4j.properties
RUN cp $SPARK_HOME/conf/log4j.properties.template $SPARK_HOME/conf/log4j.properties


RUN echo "DONE."

#Copiamos entrypoint
ADD entrypoint.sh /root/entrypoint.sh
RUN chown root:root /root/entrypoint.sh
RUN chmod a+x /root/entrypoint.sh

CMD ["/root/entrypoint.sh"]


