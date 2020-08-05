FROM pfmuah/spark-base:2.4.5-java8
LABEL maintainer="daniel.mcalleja@outlook.com"

#directorio donde se almacenan los logs
ENV SPARK_DATA=/tmp/data
RUN mkdir /tmp/data
VOLUME /tmp/data

VOLUME /opt/spark/conf

ADD run.sh /root/run.sh
RUN chmod a+x /root/run.sh

#Exponer puertos
EXPOSE 8888

CMD ["/root/run.sh"]


