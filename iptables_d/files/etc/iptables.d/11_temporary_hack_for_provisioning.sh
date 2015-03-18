# This should not be needed in general. But the provisioning process can hang
# when IPTables is initialized if we do not have this.

$IPT -A INPUT  -i $PROVISIONING_PUBLIC_INT -p tcp -s $HOST_IP_FOR_PROVISIONING --dport 22 -m comment --comment "delete-after-provisioning" -j ACCEPT
$IPT -A OUTPUT -o $PROVISIONING_PUBLIC_INT -p tcp -d $HOST_IP_FOR_PROVISIONING --sport 22 -m comment --comment "delete-after-provisioning" -j ACCEPT 
