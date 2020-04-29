FROM  tomcat:8.5.43-jdk8
MAINTAINER community-test

ENV ServName=tomcat-server \
    ServPath=$TOMCAT_HOME/webapps 

RUN mkdir -pv /data0/logs/community /data0/sa
COPY setenv.sh  $TOMCAT_HOME/bin/setenv.sh
WORKDIR $ServPath
ADD tomcat-server/target/tomcat-server-*.war ROOT.war
