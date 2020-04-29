FROM centos:centos7.6.1810

ENV LANG=en_US.UTF-8\
    PATH=/usr/local/bin:$PATH\
    PYTHON_VERSION=3.6.9

RUN yum install wget gcc gcc-c++ make zlib-devel  openssl-devel -y  && yum clean all
RUN set -ex \
    && wget --no-check-certificate -O python.tar.gz "https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz" \
    && mkdir -p /usr/src/python \
    && tar -xC /usr/src/python --strip-components=1 -f python.tar.gz \
    && rm python.tar.gz \
    && cd /usr/src/python \
    && ./configure \
    && make -j "$(nproc)" \
    && make install \
    && rm -rf /usr/src/python \
    && python3 --version

RUN cd /usr/local/bin \
	&& ln -s idle3 idle \
	&& ln -s pydoc3 pydoc \
	&& ln -s python3 python \
	&& ln -s python3-config python-config \
        && ln -s pip3 pip

CMD ["python3"]
