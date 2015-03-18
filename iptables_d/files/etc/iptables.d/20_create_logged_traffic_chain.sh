$IPT -N loggedtraffic
$IPT -A loggedtraffic -m limit --limit 15/minute -j LOG --log-prefix LoggedTraffic:
$IPT -A loggedtraffic -j DROP
