# Ensure that ssh requests from the provisioning server are allowed
# Note: Normally we just allow --state NEW,ESTABLISHED input and --state ESTABLISHED outbound.
# But when we enable this rule, we are not yet tracking state. So the first outgoing packet
# will be considered NEW, and the connection hangs.
# But this is only temporary, as this file is removed by the cleanup.sh script in the cleanup_logging task.

$IPT -A INPUT  -i $PROVISIONING_PUBLIC_INT -p tcp -s $HOST_IP_FOR_PROVISIONING --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
$IPT -A OUTPUT -o $PROVISIONING_PUBLIC_INT -p tcp -d $HOST_IP_FOR_PROVISIONING --sport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
