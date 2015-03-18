# Allow outgoing ntp traffic
$IPT -A OUTPUT -p tcp --dport 123 -m state --state NEW,ESTABLISHED -j ACCEPT
$IPT -A INPUT -p tcp --sport 123 -m state --state ESTABLISHED -j ACCEPT
