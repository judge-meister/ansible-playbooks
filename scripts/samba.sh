#!/bin/bash
set -x
. ./common.sh
run_as_root

# Install Script for SAMBA Server VM

set_hostname

# ---------------------------------------------------------------------
# install packages
apt install samba nfs-common vim git curl python3-apt qemu-guest-agent

#cp smb.conf /etc/samba/smb.conf

cp /etc/samba/smb.conf smb.conf.orig

sed -e '/^\[global\].*/r smb.conf.d/smb.global.conf' \
    -e '$r smb.conf.d/smb.shares.conf' \
    smb.conf.orig > smb.conf.new

cp smb.conf.new /etc/samba/smb.conf

echo -e "\nCreate samba password for user judge"
smbpasswd -a judge


# do sudoers
#do_sudo

# ---------------------------------------------------------------------
# fstab - setup mount points and mounting of /zdata and /zvideos from proxmox (192.168.0.30)
setup_fstab

# ---------------------------------------------------------------------
finalize
