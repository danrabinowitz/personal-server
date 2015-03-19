#!/bin/bash

function daemon_mode {
  sleep 30

  # Remove temporary iptables rule which is needed only to avoid hanging when enabling iptables in ansible
  rm -f /etc/iptables.d/11_temporary_hack_for_provisioning.sh

  # We don't need standard ssh access anymore
  rm -f /etc/iptables.d/11_allow_provisioning_command_access.sh

  # We don't need to make http calls for apt-get for provisioning
  rm -f /etc/iptables.d/52_http_for_provisioning.sh

  /etc/iptables_d.sh
}

daemon_mode </dev/null >/dev/null 2>&1 &
disown
