FROM  tomcat:8.5.43-jdk8-newrelic
MAINTAINER community-test


ENV ServName=tomcat-server \
    ServPath=$TOMCAT_HOME/webapps

RUN sed -i "s/TOMCAT_DEFAULT_NEED_TO_CHANGE/$ServName/g" $NEWRELIC_HOME/newrelic.yml
COPY setenv.sh  $TOMCAT_HOME/bin/setenv.sh`

WORKDIR $ServPath
ARG SrcCode
ADD $SrcCode ROOT.war
