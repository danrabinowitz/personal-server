# Allow incoming OpenVPN requests
$IPT -A INPUT -p udp --dport 1194 -m state --state NEW,ESTABLISHED -j ACCEPT
