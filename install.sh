#!/bin/sh -x

GBench=4.3.3
GLibC=2.17
LibStdCpp=4.8.5-36
CentOS=7.6.1810

wget http://cdn.geekbench.com/Geekbench-$GBench-Linux.tar.gz
tar xf Geekbench-$GBench-Linux.tar.gz

mkdir glibc_install; cd glibc_install 
wget http://ftp.gnu.org/gnu/glibc/glibc-$GLibC.tar.gz
tar xf glibc-$GLibC.tar.gz

cd glibc-$GLibC
mkdir build
cd build
../configure --prefix=$PWD/../../../glibc-$GLibC
make -j4
make install

cd $PWD/../../..
wget https://rpmfind.net/linux/centos/$CentOS/os/x86_64/Packages/libstdc++-$LibStdCpp.el7.x86_64.rpm
rpm2cpio ./libstdc++-$LibStdCpp.el7.x86_64.rpm | cpio -idm
mv usr/ libstdc++-$LibStdCpp/

cp Geekbench-$GBench-Linux/geekbench.plar glibc-$GLibC/lib/geekbench.plar
echo "../glibc-2.17/lib/ld-linux-x86-64.so.2 --library-path ../libstdc++-$LibStdCpp/lib64:../glibc-2.17/lib:/usr/lib:/usr/lib64:/lib:/lib64 ./geekbench_x86_64" > Geekbench-$GBench-Linux/runGeekbench.sh
chmod +x Geekbench-$GBench-Linux/runGeekbench.sh

rm -rf Geekbench-$GBench-Linux.tar.gz glibc_install libstdc++-$LibStdCpp.el7.x86_64.rpm