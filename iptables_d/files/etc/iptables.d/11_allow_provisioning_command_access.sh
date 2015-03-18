# Ensure that ssh requests from the provisioning server are allowed
$IPT -A INPUT  -i $PROVISIONING_PUBLIC_INT -p tcp -s $HOST_IP_FOR_PROVISIONING --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
$IPT -A OUTPUT -o $PROVISIONING_PUBLIC_INT -p tcp -d $HOST_IP_FOR_PROVISIONING --sport 22 -m state --state ESTABLISHED -j ACCEPT
