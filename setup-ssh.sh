#!/bin/sh -l

echo "Setuping SSH Key"

echo "$SSH_PRIVATE_KEY" | tr -d '\r' > /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa

eval "$(ssh-agent -s)"
ssh-add /root/.ssh/id_rsa