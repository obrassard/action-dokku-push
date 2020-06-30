#!/bin/sh -l

echo "Setuping SSH Key"

mkdir -p /root/.ssh
echo "$SSH_PRIVATE_KEY" | tr -d '\r' > /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa
ssh_host=$(echo $DOKKU_REPO | sed 's/.*@//' | sed 's/[:/].*//')
ssh-keyscan -H "$ssh_host" >> /root/.ssh/known_hosts
eval "$(ssh-agent -s)"
ssh-add /root/.ssh/id_rsa

echo ""
echo "Pushing to Dokku Host";

git push $DOKKU_REPO $GITHUB_SHA:refs/heads/$DEPLOY_BRANCH --force

[ $? -eq 0 ]  || exit 1

