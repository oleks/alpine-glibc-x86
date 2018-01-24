FROM portoleks/alpine:v3.7_1

MAINTAINER Oleks <oleks@oleks.info>

USER root

COPY ld.so.conf /etc/

RUN apk add --update --no-cache wget tar xz && \
    mkdir -p glibc \
    /usr/glibc && \
    ln -s /bin/bash /usr/bin/bash && \
    wget https://www.archlinux.org/packages/core/x86_64/lib32-glibc/download/ -O glibc.pkg.tar.xz && \
    tar xf glibc.pkg.tar.xz -C glibc && \
    cp -a glibc/usr /usr/glibc/ && \
    ldconfig /usr/glibc/usr /usr/glibc/usr/lib && \
    ln -s /usr/glibc/usr/lib/ld-linux.so.2 /lib/ld-linux.so.2  && \
    rm -Rf glibc glibc.pkg.tar.xz && \
    apk del wget tar xz

USER docker
