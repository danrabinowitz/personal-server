# Log new ssh connections
$IPT -A INPUT -i eth0 -p tcp --dport 22 -m state --state NEW -j LOG --log-prefix "${IPTABLES_LOG_PREFIX}: ssh connection: "
