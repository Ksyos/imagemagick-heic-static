#!/bin/bash
cd ~ && mkdir -p imagemagick-workspace && cd imagemagick-workspace && rm -rf ~/imagemagick-workspace/*
mkdir -p imagemagick-heic-static-centos7/lib && mkdir -p imagemagick-heic-static-centos7/bin

yum update -y
yum -y install libpng-devel-1.5.13

curl -L https://github.com/strukturag/libde265/releases/download/v1.0.5/libde265-1.0.5.tar.gz | tar zx
cd libde265-1.0.5
./autogen.sh && ./configure && make && make install
cd ..

curl -L https://github.com/strukturag/libheif/releases/download/v1.6.2/libheif-1.6.2.tar.gz | tar zx
cd libheif-1.6.2
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
export LDFLAGS=-L/usr/local/lib
export CPPFLAGS=-I/usr/local/include/libde265
./autogen.sh && ./configure && make && make install
cd ../

curl -L https://imagemagick.org/download/ImageMagick-7.0.10-7.tar.gz | tar zx
cd ImageMagick*
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
export LDFLAGS=-L/usr/local/lib
export CPPFLAGS=-I/usr/local/include/libheif
./configure --prefix=/root/imagemagick-workspace/imagemagick-build-output --enable-shared=no --enable-static=yes --with-heic
make && make install

cd ..
cp -P /usr/local/lib/libde265.so* imagemagick-heic-static-centos7/lib/
cp -P /usr/local/lib/libheif.so* imagemagick-heic-static-centos7/lib/
cp -P /root/imagemagick-workspace/imagemagick-build-output/bin/* imagemagick-heic-static-centos7/bin/

tar cvzf imagemagick-heic-static-centos7.tgz imagemagick-heic-static-centos7
