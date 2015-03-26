# Allow outgoing dhcp traffic
# This should not be needed in production. But in the Vagrant virtualbox vm, it
# prevents log noise.
#$IPT -A OUTPUT -p udp --dport 67 -m state --state NEW,ESTABLISHED -j ACCEPT
