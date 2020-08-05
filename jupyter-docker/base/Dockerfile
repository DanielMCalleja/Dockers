

ARG ROOT_CONTAINER=ubuntu:focal-20200423@sha256:5747316366b8cc9e3021cd7286f42b2d6d81e3d743e2ab571f55bcd5df788cc8
ARG BASE_CONTAINER=$ROOT_CONTAINER
FROM $BASE_CONTAINER

LABEL maintainer="daniel.mcalleja@outlook.com"
ARG CON_USER="root"
ARG CON_GROUP="root"

USER root

#Establecemos idioma
ENV LANG=es_ES.UTF-8

#Instalamos wget, openjdk-8-jdk, openssh-server y net-tools
RUN apt-get update && UBUNTU_FRONTEND=noninteractive apt-get install -yq less --no-install-recommends \
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
        nano \
	bzip2 \
	locales \
	fonts-liberation \
	run-one 

	
#Limpiar APT cuando termine
RUN apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Establecer idioma en container
RUN sed -i -e "s/# $LANG.*/$LANG.UTF-8 UTF-8/" /etc/locale.gen && \
    echo 'LANG="es_ES.UTF-8"' > /etc/default/locale && \
    locale-gen es_ES.UTF-8 && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=es_ES.UTF-8

#Declaración de variables para instalación 
ENV CONDA_DIR=/opt/conda \
	SHELL=/bin/bash \
	CON_USER=$CON_USER \
	CON_GROUP=$CON_GROUP

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/ \
    PATH=$PATH:$CONDA_DIR/bin:$JAVA_HOME/bin \
    HOME=/home/$CON_USER

	
#Añadimos el usuario jupyter para la administración
#RUN groupadd $CON_GROUP && \
    #useradd $CON_USER && \
    #usermod -aG $CON_GROUP $CON_USER
    #adduser --ingroup $CON_GROUP $CON_USER

RUN mkdir -p $CONDA_DIR && \
    chown $CON_USER:$CON_GROUP $CONDA_DIR && \
    chmod -R 755 $CONDA_DIR
    

#Damos permisos al directorio de trabajo 
RUN mkdir -p /home/$CON_USER && \
    chown $CON_USER:$CON_GROUP /home/$CON_USER && \
    chmod -R 755 /home/$CON_USER

#ENV NOTEBOOKS=/home/$CON_USER/notebooks

#WORKDIR $HOME
#ARG PYTHON_VERSION=3.8


#Instalamos conda
ENV MINICONDA_VERSION=4.8.2 \  
    MINICONDA_MD5=87e77f097f6ebb5127c77662dfc3165e \
    CONDA_VERSION=4.8.2

RUN set -x && \
    cd /tmp && \
    wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-py37_${MINICONDA_VERSION}-Linux-x86_64.sh \
    -O miniconda.sh  && \
    echo "${MINICONDA_MD5} miniconda.sh" | md5sum -c - && \
    /bin/bash miniconda.sh -f -b -p $CONDA_DIR && \
    echo "export PATH=$CONDA_DIR/bin:\$PATH" > /etc/profile.d/conda.sh && \
    conda config --prepend channels conda-forge && \
    conda config --set auto_update_conda false && \
    conda config --set channel_priority false && \
    conda config --set show_channel_urls true && \
    conda install --quiet --y conda && \
    conda install --quiet --y pip && \
    conda update  --quiet --all -y && \
    conda clean --all -f -y && \
    rm -rf /home/$CON_USER/.cache/yarn && \
    apt-get purge -y && \
    find "$CONDA_DIR" -follow -type f \( -iname '*.a' -o -iname '*.pyc' -o -iname '*.js.map' \) -delete && \
    rm -rf miniconda.sh

#Instalamos los paquetes
RUN conda install --quiet --y \
        'notebook=6.0.3' && \
	conda install -c conda-forge pyspark && \
	conda clean --all -f -y && \
	jupyter notebook --generate-config && \
	rm -rf $CONDA_DIR/share/jupyter/lab /staging && \
	rm -rf /home/$CON_USER/.cache/yarn

ENV PYSPARK_PYTHON=python3
ENV PYSPARK_DRIVER_PYTHON_OPTS='notebook'
ENV PYSPARK_DRIVER_PYTHON=jupyter

RUN echo "DONE."

#Creamos volumen para los notebooks
#VOLUME data/jupyter_notebooks

RUN mkdir -p /home/$CON_USER/data/notebooks && \
    chown $CON_USER:$CON_GROUP /home/$CON_USER/data/notebooks && \
    chmod -R 755 /home/$CON_USER/data/notebooks

#VOLUME /home/$CON_USER/data/notebooks


#Exponer puertos
EXPOSE 8888

#Copiamos entrypoint
ADD run.sh /root/run.sh
RUN chown $CON_USER:$CON_GROUP /root/run.sh
RUN chmod a+x /root/run.sh

RUN mkdir -p /data/notebooks && \
    chown -R :$CON_GROUP /data/notebooks && \
    chmod -R 755 /data/notebooks && \
    chmod g+s /data/notebooks

#WORKDIR /home/$CON_USER
#RUN cd /data && \
#    mkdir  ./notebooks && \
#    chown $CON_USER:$CON_GROUP ./notebooks -R && \
#    chmod -R 755 ./notebooks -R

VOLUME /data/notebooks
        
CMD ["/root/run.sh -d"]	 

