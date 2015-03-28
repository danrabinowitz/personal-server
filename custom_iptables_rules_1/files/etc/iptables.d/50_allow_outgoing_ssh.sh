REMOTE_SERVERS=('192.241.215.95')
for ip in $REMOTE_SERVERS; do
$IPT -A INPUT  -i $PUBLIC_INT -p tcp -s $ip --sport 22 -m state --state ESTABLISHED -j ACCEPT
$IPT -A OUTPUT -o $PUBLIC_INT -p tcp -d $ip --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
done
