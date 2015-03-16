#!/bin/sh
#
# Based on: http://www.linuxhelp.net/guides/iptables/
# This script is an enhanced/modified version of the iptables-script written by Davion

# The location of the IPtables binary file on your system.
IPT="/sbin/iptables"

PUBLIC_INT=`ip route show|grep 'src {{ openvpn_client_remote_ip }}' | cut -d' ' -f 3`
PRIVATE_INT=`ip route show|grep '^{{ openvpn_subnet }}'|cut -d ' ' -f 5`


# Default policies:
$IPT -P INPUT ACCEPT
$IPT -P OUTPUT ACCEPT
$IPT -P FORWARD ACCEPT


# Now, our firewall chain. We use the limit commands to
# cap the rate at which it alerts to 15 log messages per minute.
$IPT -N firewall
$IPT -A firewall -m limit --limit 15/minute -j LOG --log-prefix Firewall:
$IPT -A firewall -j DROP

# Now, our dropwall chain, for the final catchall filter.
$IPT -N dropwall
$IPT -A dropwall -m limit --limit 15/minute -j LOG --log-prefix Dropwall:
$IPT -A dropwall -j DROP

# Our "hey, them's some bad tcp flags!" chain.
$IPT -N badflags
$IPT -A badflags -m limit --limit 15/minute -j LOG --log-prefix Badflags:
$IPT -A badflags -j DROP

# And our silent logging chain.
$IPT -N silent
$IPT -A silent -j DROP


# This rule will accept connections from local machines.
$IPT -A INPUT -i lo -j ACCEPT

# This rule protects your fowarding rule.
$IPT -A FORWARD -i $PUBLIC_INT -m state --state NEW,INVALID -j DROP
$IPT -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
$IPT -A FORWARD -m limit --limit 15/minute -j LOG --log-prefix special1:
$IPT -A FORWARD -j DROP


# Drop those nasty packets! These are all TCP flag
# combinations that should never, ever occur in the
# wild. All of these are illegal combinations that
# are used to attack a box in various ways, so we
# just drop them and log them here.
$IPT -A INPUT -p tcp --tcp-flags ALL FIN,URG,PSH -j badflags
$IPT -A INPUT -p tcp --tcp-flags ALL ALL -j badflags
$IPT -A INPUT -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j badflags
$IPT -A INPUT -p tcp --tcp-flags ALL NONE -j badflags
$IPT -A INPUT -p tcp --tcp-flags SYN,RST SYN,RST -j badflags
$IPT -A INPUT -p tcp --tcp-flags SYN,FIN SYN,FIN -j badflags



# TODO: BLOCK ping on public interface!


# Drop icmp, but only after letting certain types through.
$IPT -A INPUT -p icmp --icmp-type 0 -j ACCEPT
$IPT -A INPUT -p icmp --icmp-type 3 -j ACCEPT
$IPT -A INPUT -p icmp --icmp-type 11 -j ACCEPT
$IPT -A INPUT -p icmp --icmp-type 8 -m limit --limit 1/second -j ACCEPT
$IPT -A INPUT -p icmp -j firewall

# Allow ALL ssh
$IPT -A INPUT -i $PUBLIC_INT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT
$IPT -A INPUT -i $PRIVATE_INT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT

# All other SSH attempts get logged
$IPT -A INPUT -p tcp -m state --state NEW -m tcp --dport $SSHPORT -j firewall

# TODO: Allow OpenVPN only on PUBLIC interface

# For OpenVPN
$IPT -A INPUT -p udp -m udp --dport 1194 -j ACCEPT

$IPT -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT


# TODO: Enable final trap

# Our final trap. Everything on INPUT goes to the dropwall
# so we don't get silent drops.
#$IPT -A INPUT -j dropwall
