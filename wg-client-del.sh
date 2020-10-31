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

# check for server config
if [ -f /etc/wireguard/peers/$config ]; then
  peer=$(grep PublicKey /etc/wireguard/peers/$config|cut -d ' ' -f 3)
  wg set wg0 peer $peer remove
  wg-quick save wg0
  rm /etc/wireguard/peers/$config
  echo "peer and server config for $client $device removed"
fi

# check for client config
if [ -f /etc/wireguard/clients/$config ]; then
  rm /etc/wireguard/clients/$config
  echo "client config for $client $device removed"
fi
