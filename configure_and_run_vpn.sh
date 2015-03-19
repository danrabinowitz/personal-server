#!/bin/bash
OPENVPN_NAME=$1

mv /tmp/${OPENVPN_NAME}_client_01.conf /etc/openvpn && chown root:wheel /etc/openvpn/${OPENVPN_NAME}_client_01.conf && chmod 644 /etc/openvpn/${OPENVPN_NAME}_client_01.conf
mv /tmp/${OPENVPN_NAME}_client_01.key /etc/openvpn/keys && chown root:wheel /etc/openvpn/keys/${OPENVPN_NAME}_client_01.key && chmod 400 /etc/openvpn/keys/${OPENVPN_NAME}_client_01.key
mv /tmp/${OPENVPN_NAME}_client_01.crt /etc/openvpn/keys && chown root:wheel /etc/openvpn/keys/${OPENVPN_NAME}_client_01.crt && chmod 444 /etc/openvpn/keys/${OPENVPN_NAME}_client_01.crt


PLIST=/Library/LaunchDaemons/openvpn-${OPENVPN_NAME}.plist

# Unload if there is a previous version
if [ -f ${PLIST} ];
then
  /bin/launchctl unload ${PLIST}
fi

cat << EOF | sed "s/OPENVPN_NAME/${OPENVPN_NAME}/" > ${PLIST}
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN"
"http://www.apple.com/DTDs/PropertyList-1.0.dtd";>
<plist version="1.0">
<dict>
        <key>Label</key>
        <string>openvpn-OPENVPN_NAME</string>
        <key>OnDemand</key>
        <false/>
        <key>Program</key>
        <string>/usr/local/sbin/openvpn</string>
        <key>ProgramArguments</key>
        <array>
                <string>openvpn</string>
                <string>--config</string>
                <string>OPENVPN_NAME_client_01.conf</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>TimeOut</key>
        <integer>90</integer>
        <key>WorkingDirectory</key>
        <string>/etc/openvpn</string>
</dict>
</plist>
EOF

chown root:wheel ${PLIST}
chmod 644 ${PLIST}
/bin/launchctl load ${PLIST}
