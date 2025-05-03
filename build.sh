#!/bin/bash

BASE=$(pwd)

QEMU_SOURCE=obfuscated-qemu
QEMU_TARGET=built-qemu

SEABIOS_SOURCE=seabios

# Start Python Virtual Environment
python -m venv .venv
source ./.venv/bin/activate
python3 -m pip install -r qemu-pip-requirements.txt

# Build SeaBios
cd $SEABIOS_SOURCE
rm -r out
make
echo "Output in $SEABIOS_SOURCE/out/bios.bin"
cd $BASE

# Build qemu
rm -r $QEMU_TARGET
mkdir $QEMU_TARGET
cd $QEMU_TARGET
echo "Configuring..."
QTARGETS="--target-list=i386-softmmu,x86_64-softmmu,i386-linux-user,x86_64-linux-user"
../$QEMU_SOURCE/configure $QTARGETS --prefix=/usr --libexecdir=/usr/lib/qemu --localstatedir=/var --bindir=/usr/bin/ --enable-gnutls --enable-docs --enable-gtk --enable-vnc --enable-vnc-sasl --enable-curl --enable-kvm  --enable-linux-aio --enable-cap-ng --enable-vhost-net --enable-vhost-crypto --enable-spice --enable-usb-redir --enable-lzo --enable-snappy --enable-bzip2 --enable-coroutine-pool --enable-replication --enable-tools
echo "Making..."
make

echo "Qemu made in $QEMU_TARGET"
