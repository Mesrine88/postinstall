#!/bin/bash

# Append line "PermitRootLogin yes"
echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config

#  Append line "PubkeyAuthentication yes"
echo 'PubkeyAuthentication yes' >> /etc/ssh/sshd_config

# Reload the sshd service for the changes to take effect
systemctl reload ssh