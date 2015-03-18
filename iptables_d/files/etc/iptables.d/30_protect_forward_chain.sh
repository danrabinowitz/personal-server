# This rule protects your fowarding rule.
$IPT -A FORWARD -m state --state NEW,INVALID -j DROP
