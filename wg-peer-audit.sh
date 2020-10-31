#!/bin/bash

# wg-peer-audit.sh
# check that peer config file exists for all currently active peers
# this is basis of a "cleanup" script to remove configs for invalid
# old or deleted clients

# get all peers in running wireguard server
peers=($(wg|grep peer|cut -d ' ' -f 2))

# get number of peers found above
peersCount=${#peers[@]}

# if any peers found cycle through them
if [ $peersCount -gt  0 ]; then

  for (( i=0; i<${peersCount}; i++ ));
  do
    grep -q ${peers[$i]} /etc/wireguard/peers/*.conf
    match=$?
    if [[ $match != 0 ]]; then
      echo "did not find peer config for: ${peers[$i]}"
      echo "consider removing peer now"
      #wg set wg0 peer ${peers[$i]} remove
      #wg-quick save wg0
    fi
  done

fi
