FROM oracle-java:8u212-b10-jdk-centos7.6

ENV TOMCAT_HOME /usr/local/apache-tomcat-8.5.43
ENV PATH=$TOMCAT_HOME/bin:$PATH \
    NEWRELIC_HOME=$TOMCAT_HOME/newrelic

ADD apache-tomcat-8.5.43.tar.gz /usr/local
RUN mkdir -pv $NEWRELIC_HOME $NEWRELIC_HOME/logs
ADD ./newrelic/newrelic.jar $NEWRELIC_HOME
ADD ./newrelic/newrelic.yml $NEWRELIC_HOME
RUN cd $NEWRELIC_HOME && \
    java -jar newrelic.jar install  
EXPOSE 8080
CMD ["catalina.sh", "run"]
