#!/bin/sh -l

echo "Verifying Cloudflared Installation"
/usr/local/bin/cloudflared -v

echo "Creating SSH config for Cloudflare Tunnel"
ssh_host=$(echo $DOKKU_REPO | sed -e 's/.*@//' -e 's/[:/].*//')

cat << EOF > /root/.ssh/config
Host $ssh_host
ProxyCommand /usr/local/bin/cloudflared access ssh --hostname %h --id $CLOUDFLARE_CLIENT_ID --secret $CLOUDFLARE_CLIENT_SECRET
IdentityFile /root/.ssh/id_rsa
StrictHostKeyChecking no
EOF

echo "Created /root/.ssh/config"