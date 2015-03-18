# Our final trap. Everything on OUTPUT goes to the dropwall
# so we don't get silent drops.
$IPT -A OUTPUT -j dropwall
