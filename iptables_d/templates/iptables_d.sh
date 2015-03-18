#!/bin/bash

# This script is intended to be run ONLY on provisioning, and NOT on boot.
# This script saves the rules to /etc/iptables-rules, so that on system startup,
# the rules can be restored quickly from /etc/iptables-rules.

IPT="/sbin/iptables"

# TODO: There can be more than one public interface. In a Vagrant VM, or on EC2,
# for example. How do we want to address this?
# PUBLIC_INT=`ip route show|grep 'src {{ openvpn_server_ip }}' | cut -d' ' -f 3`
PUBLIC_INT=`ip route get 8.8.8.8|head -1|cut -d' ' -f 5`

# TODO: Does the Private interface exist at this point? Not a big deal, because
# we won't be highly restrictive on the private interface. This interface should
# be what traffic coming over OpenVPN uses. Ideally it would be locked down to
# just essential traffic. But it's not a big deal because only trusted machines
# should be on the OpenVPN network anyway.
PRIVATE_INT=`ip route show|grep '^{{ openvpn_subnet }}'|cut -d ' ' -f 5`

echo "Public interface:  ${PUBLIC_INT}"
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
