FROM  centos:centos7.6.1810

ENV LANG=en_US.UTF-8\
    JAVA_HOME=/usr/local/jdk1.8.0_212

ENV PATH=$JAVA_HOME/bin:$PATH

ADD jdk-8u212-linux-x64.tar.gz /usr/local/
