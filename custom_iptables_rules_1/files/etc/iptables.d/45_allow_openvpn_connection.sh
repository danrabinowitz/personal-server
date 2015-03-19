# Allow outgoing web requests
$IPT -A INPUT -p udp --dport 1194 -m state --state NEW,ESTABLISHED -j ACCEPT
# $IPT -A OUTPUT -p udp --dport 80 -m state --state ESTABLISHED -j ACCEPT
