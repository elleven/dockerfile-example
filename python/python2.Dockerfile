FROM centos:centos7.6.1810

ENV LANG=en_US.UTF-8\
    PATH=/usr/local/bin:$PATH\
    PYTHONIOENCODING=UTF-8\
    PYTHON_VERSION=2.7.16

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
    && python2 --version

ENV PYTHON_PIP_VERSION 19.1.1

RUN set -ex; \
	\
	wget -O get-pip.py 'https://bootstrap.pypa.io/get-pip.py'; \
	\
	python get-pip.py \
		--disable-pip-version-check \
		--no-cache-dir \
		"pip==$PYTHON_PIP_VERSION" \
	; \
	pip --version; \
	rm -f get-pip.py

CMD ["python2"]
