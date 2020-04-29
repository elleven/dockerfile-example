# dockerfile 说明
## dockerfile约定及规范
[dockerfile约定]()
## 基础镜像
   python/tomcat/java
## 业务镜像
   community
### jar包启动服务 
```
FROM oracle-java:8u212-b10-jdk-centos7.6
MAINTAINER community-test

ARG SrcCode
ENV ServName=jar\
    ServPath=/data0/webservice/ \
    ServLogDir=/data0/logs/

RUN  mkdir -pv $ServPath/$ServName  $ServLogDir/$ServName

ENV JAVA_OPTS "-server -Dfile.encoding=UTF-8 -Xms3072m -Xmx3072m -XX:+PrintGC -XX:+PrintGCDetails \
              -XX:+PrintGCTimeStamps -XX:NewRatio=1 \
              -Xloggc:$ServLogDir/$ServName/gc.log"

WORKDIR $ServPath/$ServName

ADD $SrcCode $ServName.jar
ADD bootstrap.properties bootstrap.properties

EXPOSE 8080

CMD java $JAVA_OPTS -jar $ServName.jar

```

### tomcat 启动服务 
```
FROM  tomcat:8.5.43-jdk8
MAINTAINER community-test

ARG SrcCode

ENV ServName=tomcat \
    ServPath=$TOMCAT_HOME/webapps

COPY setenv.sh  $CATALINA_HOME/bin/setenv.sh
WORKDIR $ServPath
ADD $SrcCode ROOT.war
```
### python 服务 
```
FROM python:2.7.16-centos7.6
MAINTAINER community-news-test

ENV ServName=python \
    ServPath=/data0/webservice/ \
    ServLogDir=/data0/logs/

RUN  mkdir -pv $ServPath/$ServName  $ServLogDir/$ServName

WORKDIR $ServPath/$ServName

COPY requirements.txt ./
RUN pip install -r requirements.txt

COPY . .
RUN cd conf \
    && ln -s config.product.py config.py

EXPOSE 4040

CMD ["python", "translate_main.py", "4040"]
```

    
