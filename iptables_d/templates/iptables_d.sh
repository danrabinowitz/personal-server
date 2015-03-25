#!/bin/bash

# This script is intended to be run ONLY on provisioning, and NOT on boot.
# This script saves the rules to /etc/iptables-rules, so that on system startup,
# the rules can be restored quickly from /etc/iptables-rules.

IPTABLES_LOG_PREFIX='IPTABLES'

IPT="/sbin/iptables"

# TODO: There can be more than one public interface. In a Vagrant VM, or on EC2,
# for example. How do we want to address this?
HOST_IP_FOR_PROVISIONING={{ host_ip_for_provisioning.stdout }}
PROVISIONING_PUBLIC_INT=`ip route get ${HOST_IP_FOR_PROVISIONING}|sed -rn 's/^.+ dev (\w+) .+$/\1/p'`
PUBLIC_INT=`ip route get 8.8.8.8|sed -rn 's/^.+ dev (\w+) .+$/\1/p'`

# The first time(s) that we run this script, the private interface may not exist
# yet. That is not a problem. When we need the PRIVATE_INT variable, it will
# be available.
PRIVATE_INT=`ip route show|grep '^{{ openvpn_subnet }}'|cut -d ' ' -f 5`

echo "Public interface:  ${PUBLIC_INT}"
echo "Provisioning public interface:  ${PROVISIONING_PUBLIC_INT}"
echo "Private interface: ${PRIVATE_INT}"

shopt -s nullglob

IPTABLES_D_DIR=/etc/iptables.d

for f in ${IPTABLES_D_DIR}/*; do
    if [[ -f $f ]]; then
        echo "Sourcing ${f}"
        source $f
    fi
done

/sbin/iptables-save > /etc/iptables-rules
