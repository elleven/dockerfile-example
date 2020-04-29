FROM python:3.6.9-centos7.6
MAINTAINER community-news

ENV ServName=python-service \
    ServPath=/data0/webservice/ \
    ServLogDir=/data0/logs/

RUN  mkdir -pv $ServPath/$ServName  $ServLogDir/$ServName 
RUN  yum install epel-release -y && \
     rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro && \
     rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm && \
     yum install ffmpeg ffmpeg-devel -y && \
     yum clean all

WORKDIR $ServPath/$ServName

COPY requirements.txt ./
RUN pip install -r requirements.txt

COPY . .
RUN cd conf \
    && ln -s config.product.toml config.toml

EXPOSE 5001

CMD faust -A service --datadir=$ServPath/service00 worker --loglevel=INFO -p 5001
