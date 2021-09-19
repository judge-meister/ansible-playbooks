#!/bin/bash
set -x
. ./common.sh
run_as_root

# Install Script for Torrent Downloader VM
echo -e "\nNot Yet Implemented !\n"
exit

set_hostname

# ---------------------------------------------------------------------
# install packages

# transmission-remote-gtk transmission-daemon transmission-cli
# kitty jq curl sudo python3-apt python3-pip pylint3 feh figlet
# geoip-bin geoip-database
# i3 i3-wm i3status i3blocks
# xserver-xorg compton dbus-x11 copyq
# lshw apt-transport-https gnupg dnsutils
# brave-browser - use the installer below
apt install -y xserver-xorg compton dbus-x11 copyq \
               i3 i3-wm i3status i3blocks feh figlet \
               kitty jq curl sudo python3-apt python3-pip pylint3 \
               transmission-remote-gtk transmission-daemon transmission-cli \
               geoip-bin geoip-database \
               lshw apt-transport-https gnupg dnsutils

# optional packages

# ---------------------------------------------------------------------
# VNC
#  There's probably more to it that this, it can be a pain to setup.
# apt install tigervnc-common tigervnc-standalone-server
# /etc/systemd/system/vncserver@.service - optional if vnc required
# /home/judge/.vnc - config files


# -----
# python3 pip packages
# CherryPy
pip3 install CherryPy


# do sudoers
do_sudo

# ---------------------------------------------------------------------
# other configuration tasks

# /etc/fstab
# /ztorrent -> /zvideos
# /Complete - empty - not required
# /Downloads - empty - not required
# /Torrent folder containing symlink to /ztorrent/torrents

# /etc/systemd/system
# tidy_torrent.service
# cherrypy_torrent.service
# tidy_torrent.timer


# Home Directory settings etc ...
# .config/i3/*
# .config/autostart
# .config/gtk-3.0
# .config/kitty
# .config/transmission-daemon
# .config/transmission-remote-gtk
# .local/bin
# Pictures
# Downloads
# up - pia user and pass

# Other install scripts
# install_brave.sh
# install_my_motd.sh - now done via ansible
# install_pia.sh - this is the old openvpn installer


# ---------------------------------------------------------------------
# install pia-linux-3* from http://privateinternetaccess.com

# ---------------------------------------------------------------------
# fstab - setup mount points and mounting of /zdata and /zvideos from proxmox (192.168.0.30)
setup_fstab

# ---------------------------------------------------------------------
finalize
