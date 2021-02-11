ARG BUILD_FROM
FROM ${BUILD_FROM}

ENV LANG C.UTF-8

COPY run.sh /
COPY script.py /
#COPY options.json /

RUN apt update
RUN apt -y upgrade
RUN apt install -y unzip autoconf autoconf-archive libtool libkmod-dev pkg-config wget build-essential make 
RUN wget https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/snapshot/libgpiod-1.1.1.tar.gz
RUN tar -xzf libgpiod-1.1.1.tar.gz 
RUN cd libgpiod-1.1.1 
RUN ./libgpiod-1.1.1/autogen.sh --enable-tools=yes --host=arm-linux-gnueabi --prefix=/usr/local/export/rootfs ac_cv_func_malloc_0_nonnull=yes
RUN make
RUN make install

RUN apt install -y python3

RUN chmod a+x /run.sh
CMD ["/run.sh"]