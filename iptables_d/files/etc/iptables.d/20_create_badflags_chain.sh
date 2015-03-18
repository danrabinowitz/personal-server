# Our "hey, them's some bad tcp flags!" chain.
$IPT -N badflags
$IPT -A badflags -m limit --limit 5/minute -j LOG --log-prefix "${IPTABLES_LOG_PREFIX}: Badflags:"
$IPT -A badflags -j DROP
