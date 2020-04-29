FROM oracle-java:8u212-b10-jdk-centos7.6
MAINTAINER community-test

ENV ServName=java-server \
    ServPath=/data0/webservice/ \
    ServLogDir=/data0/logs/

RUN  mkdir -pv $ServPath/$ServName  $ServLogDir/$ServName

ENV JAVA_OPTS="-server -Dfile.encoding=UTF-8 -Xms4g -Xmx4g -XX:+UseG1GC -XX:MaxGCPauseMillis=100"

WORKDIR $ServPath/$ServName
ARG SrcCode

ADD $SrcCode $ServName.jar
ADD bootstrap.properties bootstrap.properties

EXPOSE 8077

CMD java $JAVA_OPTS -jar $ServName.jar

