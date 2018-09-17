#!/bin/sh -x

GBench=4.3.0
GLIBC=2.17

wget http://cdn.geekbench.com/Geekbench-$GBench-Linux.tar.gz
tar xf Geekbench-$GBench-Linux.tar.gz

mkdir glibc_install; cd glibc_install 
wget http://ftp.gnu.org/gnu/glibc/glibc-$GLIBC.tar.gz
tar xf glibc-$GLIBC.tar.gz

cd glibc-$GLIBC
mkdir build
cd build
../configure --prefix=$PWD/../../../glibc-$GLIBC
make -j4
make install

cd $PWD/../../..
wget https://rpmfind.net/linux/centos/7.5.1804/os/x86_64/Packages/libstdc++-4.8.5-28.el7.x86_64.rpm
rpm2cpio ./libstdc++-4.8.5-28.el7.x86_64.rpm | cpio -idm
mv usr/ libstdc++-4.8.5-28/

cp Geekbench-$GBench-Linux/geekbench.plar glibc-$GLIBC/lib/geekbench.plar
echo "../glibc-2.17/lib/ld-linux-x86-64.so.2 --library-path ../libstdc++-4.8.5-28/lib64:../glibc-2.17/lib:/usr/lib:/usr/lib64:/lib:/lib64 ./geekbench_x86_64" > Geekbench-$GBench-Linux/runGeekbench.sh
chmod +x Geekbench-$GBench-Linux/runGeekbench.sh

rm -rf Geekbench-$GBench-Linux.tar.gz glibc_install libstdc++-4.8.5-28.el7.x86_64.rpm