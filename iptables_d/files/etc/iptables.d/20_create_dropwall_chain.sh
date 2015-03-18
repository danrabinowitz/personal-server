# During testing, we prevent silent drops.

# TODO: Add any spammy traffic here that we do not want to see logged

$IPT -N dropwall
$IPT -A dropwall -m limit --limit 5/minute -j LOG --log-prefix Dropwall:
$IPT -A badflags -j DROP
