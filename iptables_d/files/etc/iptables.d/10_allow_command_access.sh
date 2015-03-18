# Ensure that ssh requests from the provisioning server are allowed

# TODO: For testing only I allow ALL ssh access
$IPT -A INPUT -i $PUBLIC_INT -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
$IPT -A OUTPUT -o $PUBLIC_INT -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT
