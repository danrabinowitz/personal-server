# insightseminars-linux-01="192.241.215.95"
# usm-portal-staging="54.152.188.42"
# usm-portal="54.88.102.204"
remote_servers=("192.241.215.95" "54.152.188.42" "54.88.102.204")
for ip in "${remote_servers[@]}"; do
$IPT -A INPUT  -i $PUBLIC_INT -p tcp -s $ip --sport 22 -m state --state ESTABLISHED -j ACCEPT
$IPT -A OUTPUT -o $PUBLIC_INT -p tcp -d $ip --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
true
done
