
## Ansible Playbook Collection

Needs to install ansible on host/master system (use homebrew on Mac) and then setup ssh-keys (copy them to each destination Machine/VM) and lastly set up sudoers on each machine/VM.

#### First Playbook - ping

* ansible-playbook playbook/ping.yml

#### Second Playbook - motd

Playbook to install a custom motd on all systems.

* ansible-playbook playbook/install-motd.yml

#### Initial Setup Playbook

* ansible-playbook playbook/min-setup.yml

#### Package update playbook

* ansible-playbook playbook/package-update.yml

#### Docker installer playbook

* ansible-playbook playbook/install-docker.yml
