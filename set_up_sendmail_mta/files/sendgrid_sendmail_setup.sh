#!/bin/sh

# Add SendGrid details to sendmail.mc.
grep smtp.sendgrid.net /etc/mail/sendmail.mc
if [ $? -ne 0 ]; then
  sed -i "s|dnl . Default Mailer setup|\n\
define(\`SMART_HOST', \`smtp.sendgrid.net')dnl\n\
FEATURE(\`access_db')dnl\n\
define(\`RELAY_MAILER_ARGS', \`TCP \$h 587')dnl\n\
define(\`ESMTP_MAILER_ARGS', \`TCP \$h 587')dnl\n\
\n\
dnl # Default Mailer setup|" /etc/mail/sendmail.mc

  m4 /etc/mail/sendmail.mc > /etc/mail/sendmail.cf
fi
