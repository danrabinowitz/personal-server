# Set default policies. If being conservative and setting the defaults to drop,
# this should be done BEFORE flushing.
$IPT -P INPUT DROP
$IPT -P OUTPUT DROP
$IPT -P FORWARD DROP
