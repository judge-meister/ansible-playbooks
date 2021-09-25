#!/bin/bash
set -x
. ./common.sh
run_as_root

# Install Script for ... VM
echo -e "\nNot Yet Implemented !\n"
exit

set_hostname

# ---------------------------------------------------------------------
# install packages
apt install -y man vim nfs-client

# do sudoers
do_sudo

# ---------------------------------------------------------------------
# other configuration tasks
setup_fstab

# ---------------------------------------------------------------------
finalize
