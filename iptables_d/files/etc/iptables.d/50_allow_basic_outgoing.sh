# DNS
DNS_SERVER="8.8.8.8 10.0.2.3"
for ip in $DNS_SERVER
do
$IPT -A OUTPUT -p udp --sport 1024:65535 -d $ip --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT
$IPT -A INPUT -p udp -s $ip --sport 53 --dport 1024:65535 -m state --state ESTABLISHED -j ACCEPT
$IPT -A OUTPUT -p tcp --sport 1024:65535 -d $ip --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT
$IPT -A INPUT -p tcp -s $ip --sport 53 --dport 1024:65535 -m state --state ESTABLISHED -j ACCEPT
done


# # Allow outgoing web requests
# $IPT -A OUTPUT -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
# $IPT -A INPUT -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT
