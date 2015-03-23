# Allow outgoing SMTP requests to SendGrid
$IPT -A OUTPUT -p tcp --dport 587 -m state --state NEW,ESTABLISHED -j ACCEPT
$IPT -A INPUT -p tcp --sport 587 -m state --state ESTABLISHED -j ACCEPT
