# Ensure that ssh requests over the OpenVPN interface are allowed
$IPT -A INPUT  -i $PRIVATE_INT -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
$IPT -A OUTPUT -o $PRIVATE_INT -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT
