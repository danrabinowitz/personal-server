# Allow outgoing dhcp traffic
# This should not be needed in production. But in the Vagrant virtualbox vm, it
# prevents log noise.
# Update: It IS used on the EC2 service.

DHCP_SERVERS=$(cat /var/lib/dhcp/dhclient.eth0.leases |sed -rn 's/^ .+dhcp-server-identifier ([0-9].+);$/\1/p'|sort -u)
for ip in $DHCP_SERVERS; do
$IPT -A OUTPUT -p udp -d $ip --dport 67 -m state --state NEW,ESTABLISHED -j ACCEPT
done
