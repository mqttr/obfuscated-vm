#!/bin/bash

# Win Installer ($1) is the installer for your OS. Typically an ISO file. Only needed when setting up the OS
WIN_INSTALLER=$1
# Target for the raw virtual hard drive
OS_LOCATION=$2
BIOS=seabios/out

./built-qemu/qemu-system-x86_64 -enable-kvm \
	-cpu host,kvm=off,vmx=on,hypervisor=off,hv_vendor_id=GenuineIntel \
	-drive file=$OS_LOCATION,if=ide,format=raw \
	-drive file=$WIN_INSTALLER,media=cdrom \
	-m 16G -boot d \
	-rtc base=localtime,clock=host -smp cores=2,threads=4 \
	-device virtio-net-pci \
	-usb \
	-device usb-tablet \
	-device qemu-xhci,id=xhci \
	-device usb-host,vendorid=0x04f2,productid=0xb64f \
	-device usb-host,vendorid=0x2972,productid=0x0047 \
	-device usb-host,vendorid=0x0909,productid=0x004d \
	-L seabios/out \
	-smbios type=1,manufacturer="Dell",product="Optiplex" \
	-smbios type=17,manufacturer=Samsung,serial=12345678 \
	-acpitable file=wmi_spoof/dsdt.aml \
	-sandbox on,obsolete=deny,elevateprivileges=deny,spawn=deny,resourcecontrol=deny -msg timestamp=on

