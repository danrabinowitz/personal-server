# Our final trap. Everything on INPUT goes to the dropwall
# so we don't get silent drops.
$IPT -A INPUT -j dropwall
