#!/bin/bash
set -x
set -e
. ./common.sh
run_as_root

# Install Script for Print Server VM

set_hostname

# ---------------------------------------------------------------------
# install packages
# foomatic-filters conflicts with cups-filters
apt update
apt install -y curl git vim qemu-guest-agent python3-apt \
               build-essential tix  groff dc man file \
               cups printer-driver-foo2zjs

# ---------------------------------------------------------------------
# Allow remote access to cups web interface
cupsctl --remote-admin --remote-any --share-printers
#systemctl restart cups

# ---------------------------------------------------------------------
set +x
echo ""
echo "Passthru the usb printer to the VM: on the proxmox host:"
echo "  \$ lsusb | grep Laser"
echo "      Bus 002 Device 003: ID 03f0:2c17 HP LaserJet 1022 Printer"
echo "  \$ qm set <vmid> -usb0 host=03f0:2c17"
echo ""

# ---------------------------------------------------------------------
echo ""
echo "Create printers (Debian)"
echo "    Connect with a web browser to:"
echo "        http://<hostname>:631"
echo "    And configure printer (HP example shown) to:"
echo "        HP LaserJet 1020n, Foomatic + foo2zjs (en)"
echo "    Then edit \"Manage Printers->Configure Printer\" to suit you,"
echo "    such as \"Page Size\" or \"Color Mode\"."
echo ""

# ---------------------------------------------------------------------
finalize
