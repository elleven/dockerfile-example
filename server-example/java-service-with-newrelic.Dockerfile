FROM oracle-java:8u212-b10-jdk-centos7.6-newrelic
MAINTAINER community-test

ENV ServName=java-service \
    ServPath=/data0/webservice/ \
    ServLogDir=/data0/logs/

RUN  mkdir -pv $ServPath/$ServName  $ServLogDir/$ServName && \
     sed -i "s/JDK_DEFAULT_NEED_TO_CHAGE/$ServName/g" $NEWRELIC_HOME/newrelic.yml

ENV JAVA_OPTS="-server -Dfile.encoding=UTF-8 -Xms3072m -Xmx3072m -XX:+PrintGC -XX:+PrintGCDetails \
              -XX:+PrintGCTimeStamps -XX:NewRatio=1 \
              -Xloggc:$ServLogDir/$ServName/gc.log  \
              -javaagent:$NEWRELIC_HOME/newrelic.jar"

WORKDIR $ServPath/$ServName
ARG SrcCode

ADD $SrcCode $ServName.jar
ADD bootstrap.properties bootstrap.properties

EXPOSE 8080

CMD java $JAVA_OPTS -jar $ServName.jar
