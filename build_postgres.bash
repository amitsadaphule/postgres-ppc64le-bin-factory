#!/bin/bash

cd $HOME

CWD=`pwd`

yum install -y git readline-devel zlib-devel \
    flex bison libxml2-devel libxslt-devel git gcc gcc-c++ make

INSTALL_PREFIX=$CWD/pginstall
mkdir $INSTALL_PREFIX

git clone https://github.com/postgres/postgres
cd postgres
git checkout tags/REL9_6_18
./configure
make LDFLAGS_EX=' -Wl,--enable-new-dtags,-rpath,"\$$ORIGIN/../lib"'
make DESTDIR=$INSTALL_PREFIX install
cd contrib
make LDFLAGS_EX=' -Wl,--enable-new-dtags,-rpath,"\$$ORIGIN/../lib"'
make DESTDIR=$INSTALL_PREFIX install

cd $INSTALL_PREFIX/usr/local/pgsql
tar czf postgresql-Linux-ppc64le.tar.gz bin include lib share
mv postgresql-Linux-ppc64le.tar.gz $INSTALL_PREFIX/
cd $INSTALL_PREFIX
rm -rf usr

