#!/bin/bash
set -e

# things to install for ansible to work

if [ -z "$1" ]
then
  hostip=""
  while [ -z "$hostip" ]
  do
    echo -en "Enter ip address to setup for ansible: "
    read ANS
    ping -c1 $ANS >/dev/null
    if [ $? -eq 0 ]
    then
      hostip=$ANS
    fi
  done
else
  hostip=$1
fi

# ssh key
echo "Enter password for ${hostip} to transfer ssh key"
ssh-copy-id ${hostip}

# install and setup sudo
echo -e "\nEnter root password for remote host."
ssh ${hostip} '(su -c "apt update; apt install -y sudo python3-apt")'
echo -e "\nEnter root password for remote host."
ssh ${hostip} '(echo "judge  ALL=(ALL) NOPASSWD: ALL" > ~/judge_sudo; chmod +x ~/judge_sudo; su -c "cp /home/judge/judge_sudo /etc/sudoers.d/judge"; rm -f ~/judge_sudo)'

# finalise
echo -e "\nAnsible should now be able to communicate with ${hostip}."
echo -e "Testing ansible."

ansible all -i ${hostip}, -m ping
echo "res: $?"

