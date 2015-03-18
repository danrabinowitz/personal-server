# All other SSH attempts get logged
$IPT -A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j loggedtraffic
