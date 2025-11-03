#! /bin/bash

set -e

WORKSPACE=/tmp/workspace
mkdir -p $WORKSPACE
mkdir -p /work/artifact

# hwloc
git clone https://github.com/open-mpi/hwloc
cd hwloc
./autogen.sh
LDFLAGS="-static --static -no-pie -s" ./configure --prefix=/usr --disable-shared --enable-static
make
make install

# htop
cd $WORKSPACE
aa=3.4.1
curl -sL https://github.com/htop-dev/htop/releases/download/$aa/htop-$aa.tar.xz | tar x --xz
cd htop-$aa
LDFLAGS="-static --static -no-pie -s -lunwind" ./configure --prefix=/usr/local/htopmm --enable-unicode --enable-static --enable-capabilities --enable-vserver --enable-openvz --enable-sensors --enable-hwloc 
make
make install


cd /usr/local
tar vcJf ./htopmm.tar.xz htopmm

mv ./htopmm.tar.xz /work/artifact/
