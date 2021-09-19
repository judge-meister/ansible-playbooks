#### VM Install Scripts

First stab at script to install various VM on my Proxmox Server.

* gallery.sh - web server (apache, could also try nginx)
* torrent.sh - downloader with pia VPN config
* emby.sh - media server if I want to stop using docker
* debianjet - print server for HP 1020 USB laser printer
* samba.sh - samba server sharing /zdata and /zvideos

Should probably convert these to ansible playbooks in the future.

Ansible will need something to initialise the VM after OS installation to add sudoers config and ssh-key before the playbook can be run.
