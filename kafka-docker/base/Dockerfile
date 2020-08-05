FROM  ubuntu:20.04
LABEL maintainer="daniel.mcalleja@outlook.com"

#Instalamos componentes
RUN apt-get update && UBUNTU_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
	apt-transport-https \
        ca-certificates \ 
        curl \
	wget \
        software-properties-common \
        openjdk-8-jdk \
	openssh-server openssh-client net-tools \
        gpg-agent \
	&& rm -rf /var/lib/apt/lists/*

RUN apt-get autoremove && apt-get clean

#Creamos directorio para mover los archivos
RUN mkdir -p /tmp

#Declaramos variables para instalación
ENV KAFKA_VERSION 2.12-2.5.0
ENV KAFKA_URL https://downloads.apache.org/kafka/2.5.0/kafka_2.12-2.5.0.tgz
ENV KAFKA_ASC_URL https://downloads.apache.org/kafka/2.5.0/kafka_2.12-2.5.0.tgz.asc

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
ENV KAFKA_HOME=/opt/kafka
ENV PATH=$PATH:$JAVA_HOME/bin:$KAFKA_HOME/bin:$KAFKA_HOME/sbin
USER root

RUN wget https://dist.apache.org/repos/dist/release/kafka/KEYS
RUN gpg --import KEYS

RUN set -x && \
    curl -fsSL "$KAFKA_URL" -o /tmp/kafka_$KAFKA_VERSION.tgz && \
    curl -fsSL "$KAFKA_ASC_URL" -o /tmp/kafka_$KAFKA_VERSION.tgz.asc && \
    gpg --verify /tmp/kafka_$KAFKA_VERSION.tgz.asc /tmp/kafka_$KAFKA_VERSION.tgz && \
    gpg --print-md SHA256 /tmp/kafka_$KAFKA_VERSION.tgz && \
    tar -zxvf /tmp/kafka_$KAFKA_VERSION.tgz -C /tmp && \
    mv /tmp/kafka_$KAFKA_VERSION /opt/kafka && \
    rm /tmp/kafka_$KAFKA_VERSION.tgz*

#Copiamos archivos de configuracion
COPY ./config/* /tmp/

#Movemos los archivos de los servicios de zookeeper y kafka
RUN mv /tmp/server.properties /opt/kafka/config/server.properties
RUN mv /tmp/zookeeper.properties /opt/kafka/config/zookeeper.properties


RUN echo "DONE."

#Copiamos entrypoint     
ADD entrypoint.sh /entrypoint.sh
RUN chown root:root /entrypoint.sh
RUN chmod a+x /entrypoint.sh

CMD ["/entrypoint.sh"]
