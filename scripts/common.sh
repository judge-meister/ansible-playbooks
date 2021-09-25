#
# common functions for install scripts in this folder
#

# ---------------------------------------------------------------------
run_as_root()
{
  # run as root
  if [ "$USER" != "root" ]
  then
    echo "run as root."
    exit
  fi
}

# ---------------------------------------------------------------------
do_sudo()
{
  if [ ! -f "/etc/sudoers.d/judge" ]
  then
    # sudo - when converting to ansible sudo will already be set up
    echo "judge  ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/judge
    chmod 644 /etc/sudoers.d/judge
  fi
}

# ---------------------------------------------------------------------
static_network()
{
  # still figuring out how to implement a static network automatically
  # - ask for IPADDR
  # - apply it to config
  echo "TO DO: setup static network."
}

# ---------------------------------------------------------------------
qm_settings()
{
  # auto update some proxmox vm settings like guest agent
  # - ask for VM id
  # - make changes via qm on proxmox host
  echo "TO DO: qm_settings"
}

# ---------------------------------------------------------------------
setup_fstab()
{
  mkdir -p /zdata /zvideos

  grep -q zvideos /etc/fstab
  if [ $? -eq 1 ]
  then
    echo -e "proxmox:/zvideos\t/zvideos\tnfs4\tdefaults,auto\t0 0" >> /etc/fstab
  fi

  grep -q zdata /etc/fstab
  if [ $? -eq 1 ]
  then
    echo -e "proxmox:/zdata  \t/zdata  \tnfs4\tdefaults,auto\t0 0" >> /etc/fstab
  fi

  grep -q proxmox /etc/hosts
  if [ $? -eq 1 ]
  then
    echo "192.168.0.30	proxmox.localdomain	proxmox" >> /etc/hosts
  fi
}

# ---------------------------------------------------------------------
set_hostname()
{
  NEWHOSTNAME=""
  if [ -z "$1" ]
  then
    while [ -z "$NEWHOSTNAME" ]
    do
      echo -en "\nEnter hostname for this vm: "
      read NEWHOSTNAME
    done
  else
    NEWHOSTNAME="$1"
  fi
  hostnamectl set-hostname "$NEWHOSTNAME"
  sed -i 's|bullseye|'$NEWHOSTNAME'|g' /etc/hosts
}

# ---------------------------------------------------------------------
finalize()
{
  echo -e "\nStill to do.\nEnable qemu-guest-agent on proxmox control page."
  echo -e "or 'qm set $VMID --agent 1' on proxmox command line"

  echo -e "\nSet static address for this VM in pfsense [Services->DHCP Server->LAN]."
  IPADDR=$(ip a | grep link/ether | awk -F' ' '{print $2}')
  if [ "$IPADDR" != "" ]
  then
  	echo "mac address is $IPADDR"
  fi

  echo "Now power down and restart the VM."
  echo -n "Continue to power off VM ? [Y/n] "
  read ANS
  if [ "$ANS" != "n" ]
  then
  	poweroff
  fi
}
