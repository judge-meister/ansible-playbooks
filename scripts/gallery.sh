#!/bin/bash
set -x
. ./common.sh
run_as_root

# Install Script for Gallery Web Server VM

set_hostname

# ---------------------------------------------------------------------
# install packages
apt install -y sudo php apache2 git qemu-guest-agent vim curl net-tools figlet dnsutils python3-apt nfs-common man w3m

# ---------------------------------------------------------------------
# do sudoers
do_sudo

# ---------------------------------------------------------------------
# fstab - setup mount points and mounting of /zdata and /zvideos from proxmox (192.168.0.30)
setup_fstab

# ---------------------------------------------------------------------
# create new /etc/apache2/sites-available/000-default
# create symlink of 000-default in sites-enabled

rm -f /root/000-default.conf
cat > /root/000-default.conf << .EOF
<VirtualHost *:80>
	# The ServerName directive sets the request scheme, hostname and port that
	# the server uses to identify itself. This is used when creating
	# redirection URLs. In the context of virtual hosts, the ServerName
	# specifies what hostname must appear in the request's Host: header to
	# match this virtual host. For the default virtual host (this file) this
	# value is not decisive as it is used as a last resort host regardless.
	# However, you must set it for any further virtual host explicitly.
	ServerName gallery

	ServerAdmin webmaster@localhost

	#DocumentRoot /var/www/html
	DocumentRoot /zdata/webroot/html
	<Directory "/zdata/webroot/html">
		Options +Indexes +FollowSymLinks +MultiViews
		AllowOverride All
		<RequireAny>
			Require all denied
			Require ip 10.0.1 127.0.0.1 192.168.0 192.168.20
		</RequireAny>
		RedirectMatch ^/$ /index.php
	</Directory>

	ScriptAlias /cgi-bin/ /zdata/webroot/cgi-bin/
	<Directory "/zdata/webroot/cgi-bin">
		Options +ExecCGI
		AddHandler cgi-script .py
		<RequireAny>
			Require all denied
			Require ip 10.0.1 127.0.0.1 192.168.0 192.168.20
		</RequireAny>
	</Directory>

	# Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
	# error, crit, alert, emerg.
	# It is also possible to configure the loglevel for particular
	# modules, e.g.
	#LogLevel info ssl:warn

	ErrorLog \${APACHE_LOG_DIR}/error.log
	CustomLog \${APACHE_LOG_DIR}/access.log combined

	# For most configuration files from conf-available/, which are
	# enabled or disabled at a global level, it is possible to
	# include a line for only one particular virtual host. For example the
	# following line enables the CGI configuration for this host only
	# after it has been globally disabled with "a2disconf".
	#Include conf-available/serve-cgi-bin.conf
</VirtualHost>


# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
.EOF

cp -f /root/000-default.conf /etc/apache2/sites-available/
cd /etc/apache2/sites-enabled
rm -f 000-default.conf
ln -s ../sites-available/000-default.conf .

# enable re-write engine module
a2enmod rewrite


# ---------------------------------------------------------------------
# fix networking as static address (to replace old lxc container address of 192.168.0.11)
#
# if using dhcp this can be fixed via pfsense, but it might also be a good idea to fix it locally
#

#cat > /etc/systemd/network/lan0.network << .EOF
#[Match]
#Name=ens18

#[Network]
#Address=192.168.0.11
#Gateway=192.168.0.1

#.EOF

#systemctl daemon-reload
#systemctl enable systemd-networkd
#systemctl enable qemu-guest-agent

# ---------------------------------------------------------------------
finalize
