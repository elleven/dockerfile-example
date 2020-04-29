FROM oracle-java:8u212-b10-jdk-centos7.6

ENV TOMCAT_HOME /usr/local/apache-tomcat-8.5.43
ENV PATH $TOMCAT_HOME/bin:$PATH

ADD apache-tomcat-8.5.43.tar.gz /usr/local
EXPOSE 8080
CMD ["catalina.sh", "run"]
