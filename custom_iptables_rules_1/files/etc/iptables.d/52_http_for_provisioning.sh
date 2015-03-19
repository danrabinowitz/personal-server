# Allow outgoing web requests
$IPT -A OUTPUT -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
$IPT -A INPUT -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT
