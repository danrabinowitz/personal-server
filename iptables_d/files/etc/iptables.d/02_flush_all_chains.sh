# Flush all chains. This results in chains with no rules.
$IPT -F

# Delete all chains, except the defaults: INPUT, FORWARD, and OUTPUT.
$IPT -F
