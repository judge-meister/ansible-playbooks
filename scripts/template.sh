#!/bin/bash
set -x
. ./set_hostname
common.sh
run_as_root

# Install Script for ... VM
echo -e "\nNot Yet Implemented !\n"
exit

set_hostname

# ---------------------------------------------------------------------
# install packages
apt install -y ...

# do sudoers
do_sudo

# ---------------------------------------------------------------------
# other configuration tasks
setup_fstab

# ---------------------------------------------------------------------
finalize
