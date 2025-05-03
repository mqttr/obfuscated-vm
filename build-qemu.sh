#!/bin/bash

SOURCE=obfuscated-qemu
TARGET=built-qemu

# Start Python Virtual Environment
python -m venv .venv
source ./.venv/bin/activate
python3 -m pip install -r qemu-pip-requirements.txt

# Build qemu
mkdir $TARGET
cd $TARGET
echo "Configuring..."
QTARGETS="--target-list=i386-softmmu,x86_64-softmmu,i386-linux-user,x86_64-linux-user"
../$SOURCE/configure $QTARGETS --prefix=/usr --libexecdir=/usr/lib/qemu --localstatedir=/var --bindir=/usr/bin/ --enable-gnutls --enable-docs --enable-gtk --enable-vnc --enable-vnc-sasl --enable-curl --enable-kvm  --enable-linux-aio --enable-cap-ng --enable-vhost-net --enable-vhost-crypto --enable-spice --enable-usb-redir --enable-lzo --enable-snappy --enable-bzip2 --enable-coroutine-pool --enable-replication --enable-tools
echo "Making..."
make

echo "Qemu made in $TARGET"
