#! /bin/bash

set -e

WORKSPACE=/tmp/workspace
mkdir -p $WORKSPACE
mkdir -p /work/artifact

# htop
cd $WORKSPACE
aa=3.4.1
curl -sL https://github.com/htop-dev/htop/releases/download/$aa/htop-$aa.tar.xz | tar x --xz
cd htop-$aa
LDFLAGS="-static --static -no-pie -s -lunwind" ./configure --prefix=/usr/local/htopmm --enable-unicode --enable-static --enable-capabilities --enable-vserver --enable-openvz --enable-sensors
make
make install
ldconfig 


cd /usr/local
tar vcJf ./htopmm.tar.xz htopmm

mv ./htopmm.tar.xz /work/artifact/
