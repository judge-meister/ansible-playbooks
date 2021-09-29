#!/bin/bash
set -x
. ./common.sh
run_as_root

# Install Script for EMBY VM
#echo -e "\nNot Yet Implemented !\n"
#exit

set_hostname

# ---------------------------------------------------------------------
# install packages
apt install -y man vim nfs-client curl htop file

curl -o emby-server-deb_4.6.4.0_amd64.deb  "https://github.com/MediaBrowser/Emby.Releases/releases/download/4.6.4.0/emby-server-deb_4.6.4.0_amd64.deb"

dpkg -i emby-server-deb_4.6.4.0_amd64.deb 

# do sudoers
#do_sudo

# ---------------------------------------------------------------------
# other configuration tasks

# ---------------------------------------------------------------------
# fstab - setup mount points and mounting of /zdata and /zvideos from proxmox (192.168.0.30)
setup_fstab

# ---------------------------------------------------------------------
finalize
