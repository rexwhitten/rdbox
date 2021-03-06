#!/bin/bash

source /home/${SUDO_USER}/.bashrc.rdbox-hq

# IP address for vpnserver
VPN_RDBOX_ADDRESS=`ipcalc ${RDBOX_NET_ADRS_KUBE_MASTER} ${RDBOX_NET_SUBNETMASK} | grep -i address | sed -e 's#  *# #g' | cut -f 2 -d ' '`
VPN_RDBOX_NETMASK=`ipcalc ${RDBOX_NET_ADRS_KUBE_MASTER} ${RDBOX_NET_SUBNETMASK} | grep -i netmask | sed -e 's#  *# #g' | cut -f 4 -d ' '`
FILE_CLOUD_INIT_RDBOX=/home/${SUDO_USER}/rdbox/tmp/50-cloud-init.kube_master.yaml
cat << EOS_RDBOX > ${FILE_CLOUD_INIT_RDBOX}
network:
    ethernets:
        vpn_rdbox:
            addresses:
            - ${VPN_RDBOX_ADDRESS}/${VPN_RDBOX_NETMASK}
    version: 2
EOS_RDBOX

#
FILE_NETPLAN_CLOUD_INIT=/etc/netplan/99-vpn.yaml
cp ${FILE_CLOUD_INIT_RDBOX} "${FILE_NETPLAN_CLOUD_INIT}"