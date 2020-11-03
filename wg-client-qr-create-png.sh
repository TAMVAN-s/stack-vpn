#!/bin/bash

# check for and set client name
if [ -n "$1" ]; then
  client=$1
  # set beginning of config file name
  config=$client
else
  echo "client name not set"
  exit 1
fi

# check if device name was set
if [ -n "$2" ]; then
  device=$2
else
  device=default
fi

# add device name & .conf to config file name
config=$config.$device.conf
image=$config.$device.png

# check for existing config
if [ -f /etc/wireguard/clients/$config ]; then

  if [ ! -d /var/lib/wireguard ]; then
    install --owner=root --group=root --mode=700 --directory /var/lib/wireguard
  fi
  qrencode -t png -r /etc/wireguard/clients/$config -o /var/lib/wireguard/$image

else
  echo "config for $client $device does not exist"
fi
