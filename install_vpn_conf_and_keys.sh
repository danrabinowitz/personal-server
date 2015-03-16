#!/bin/bash
OPENVPN_NAME=$1

mv /tmp/${OPENVPN_NAME}_client_01.conf /etc/openvpn && chown root:wheel /etc/openvpn/${OPENVPN_NAME}_client_01.conf && chmod 644 /etc/openvpn/${OPENVPN_NAME}_client_01.conf
mv /tmp/${OPENVPN_NAME}_client_01.key /etc/openvpn/keys && chown root:wheel /etc/openvpn/keys/${OPENVPN_NAME}_client_01.key && chmod 400 /etc/openvpn/keys/${OPENVPN_NAME}_client_01.key
mv /tmp/${OPENVPN_NAME}_client_01.crt /etc/openvpn/keys && chown root:wheel /etc/openvpn/keys/${OPENVPN_NAME}_client_01.crt && chmod 444 /etc/openvpn/keys/${OPENVPN_NAME}_client_01.crt
