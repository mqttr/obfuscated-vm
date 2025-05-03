#!/bin/bash

WIN_INSTALLER=/mnt/Secondary/VMs/Sources/Win10.iso
OS_LOCATION=/mnt/Secondary/VMs/Custom
BIOS=

sudo ./built-qemu/qemu-system-x86_64 --enable-kvm \
	-drive file=$OS_LOCATION,if=ide \        # Main Storage Drive
	-m 16G -boot d
	-drive file=$WIN_INSTALLER,media=cdrom \      # Flashing ISO Drive
	-rtc base=localtime,clock=host -smp cores=2,threads=4 -cpu host \
	-L ../../seabios/out/bios.bin \
	-device virtio-net-pci \                                        # Network Card
	-usb -device usb-tablet \
	-device qemu-xhci,id=xhci \
	-device usb-host,vendorid=0x04f2,productid=0xb64f \             # Camera
	-device usb-host,vendorid=0x2972,productid=0x0047 \             # Headphone DAC
	-device usb-host,vendorid=0x0909,productid=0x004d               # Microphone

# ./qemu-system-x86_64 --enable-kvm -drive file=/mnt/Secondary/vm/virtualdisk.qcow2,if=ide -m 8G -boot d -drive file=/home/mattr/Downloads/Win10.iso,media=cdrom -rtc base=localtime,clock=host -smp cores=2,threads=4 -usb -device usb-tablet -L ../pc-bios/ -cpu host -device virtio-net-pci -device qemu-xhci,id=xhci -device usb-host,vendorid=0x04f2,productid=0xb64f -device usb-host,vendorid=0x2972,productid=0x0047
