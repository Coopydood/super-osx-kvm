#!/usr/bin/env bash
# shellcheck disable=SC2054

# APC-RUN_2022-12-28_12-21-20

############################################################
#	YOU CAN USE THIS FILE TO MANUALLY CREATE A BOOT SCRIPT #
#	INSTEAD OF USING AUTOPILOT.                            #
############################################################

#
#	Created by Coopydood as part of the ultimate-macOS-KVM project.
#
#	Profile: https://github.com/Coopydood
#	Repo: https://github.com/Coopydood/ultimate-macOS-KVM
#
#	Adapted from OSX-KVM among others.
#	Greetz to TheNickDude, Dortania, khoalia, foxlet, and other contributors :]
#

ID="macOS"
NAME="macOS 10.15"
FILE="bootExample.sh"

ULTMOS=0.10.0
IGNORE_FILE=0
REQUIRES_SUDO=0
VFIO_PTA=0
VFIO_DEVICES=0
GEN_EPOCH=000000000
VERBOSE=1
DISCORD_RPC=1

SCREEN_RES="1280x720"

ALLOCATED_RAM="4G"
CPU_SOCKETS="1"
CPU_CORES="2"
CPU_THREADS="2"
CPU_MODEL="Haswell-NoTSX"
CPU_FEATURE_ARGS="+ssse3,+sse4.2,+popcnt,+avx,+aes,+xsave,+xsaveopt,check"

REPO_PATH="."
OVMF_DIR="./ovmf"

VFIO_ID_0="$USR_VFIO_ID_0"
VFIO_ID_1="$USR_VFIO_ID_1"
VFIO_ROM="$USR_VFIO_ROM"

USB_DEVICES="$USR_USB_DEVICES"

NETWORK_DEVICE="$USR_NETWORK_DEVICE"
MAC_ADDRESS="$USR_MAC_ADDRESS"

OS_ID="$USR_OS_NAME"

#   You should not have to touch anything below this line, especially if you
#   don't really know what you're doing. It'll probably break something.

args=(
-global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off
-enable-kvm -m "$ALLOCATED_RAM" -cpu "$CPU_MODEL",kvm=on,vendor=GenuineIntel,+invtsc,vmware-cpuid-freq=on,"$CPU_FEATURE_ARGS"
-machine q35
-usb -device usb-kbd -device usb-tablet #USB_DEV
-smp "$CPU_THREADS",cores="$CPU_CORES",sockets="$CPU_SOCKETS"
-device usb-ehci,id=ehci
-device qemu-xhci,id=xhci
-device pcie-root-port,bus=pcie.0,slot=1,x-speed=16,x-width=32
#VFIO_DEV_BEGIN
#VFIO_DEV_END
-device isa-applesmc,osk="ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
-drive if=pflash,format=raw,readonly=on,file="$REPO_PATH/$OVMF_DIR/OVMF_CODE.fd"
-drive if=pflash,format=raw,file="$REPO_PATH/$OVMF_DIR/OVMF_VARS.fd"
-smbios type=2
-device ich9-intel-hda -device hda-duplex
-device ich9-ahci,id=sata
-drive id=OpenCore,if=none,format=qcow2,file="$REPO_PATH/boot/OpenCore.qcow2"
-drive id=HDD,if=none,file="$REPO_PATH/HDD.qcow2",format=qcow2
-device ide-hd,bus=sata.2,drive=OpenCore
-device ide-hd,bus=sata.3,drive=HDD

############## REMOVE THESE LINES AFTER MACOS INSTALLATION ###############
-drive id=BaseSystem,if=none,file="$REPO_PATH/BaseSystem.img",format=raw
-device ide-hd,bus=sata.4,drive=BaseSystem
##########################################################################

-netdev user,id=net0 -device "$NETWORK_DEVICE",netdev=net0,id=net0,mac="$MAC_ADDRESS"
-device qxl-vga,vgamem_mb=128,vram_size_mb=128    
-monitor stdio
#-display none
#-vga qxl

################ UNCOMMENT IF YOU WANT TO USE VNC MONITOR ################
#-vnc 0.0.0.0:1,password=on -k en-us
##########################################################################

)

while getopts d: flag
do
    case "${flag}" in
        d) DISCORD_RPC=${OPTARG};;
    esac
done

if [ $VERBOSE = 1 ]
then
echo
echo \ \ \──────────────────────────────────────────────
echo \ \ \ \ \ $NAME
echo
echo \ \ \ \ \ $FILE
echo \ \ \ \ \ Built with ULTMOS v$ULTMOS
echo \ \ \ \ \ Using $CPU_MODEL CPU model
if [ $REQUIRES_SUDO = 1 ]
then
echo \ \ \ \ \ Superuser privileges enabled
fi
if [ $VFIO_PTA = 1 ]
then
echo \ \ \ \ \ Passthrough enabled
else
echo \ \ \ \ \ Passthrough disabled
fi
if [ $DISCORD_RPC = 1 ]
then
echo \ \ \ \ \ Discord RPC enabled
else
echo \ \ \ \ \ Discord RPC disabled
fi
echo \ \ \──────────────────────────────────────────────
echo
fi

if [ $DISCORD_RPC = 1 ]
then
$REPO_PATH/scripts/drpc.py --os "$OS_ID" --pt $VFIO_DEVICES --wd $REPO_PATH &
fi

qemu-system-x86_64 "${args[@]}"

if [ $DISCORD_RPC = 1 ]
then
pkill -f drpc.py
fi
