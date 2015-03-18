$IPT -N loggedtraffic
$IPT -A loggedtraffic -m limit --limit 15/minute -j LOG --log-prefix "${IPTABLES_LOG_PREFIX}: LoggedTraffic:"
$IPT -A loggedtraffic -j DROP
