#!/bin/sh -l

echo "Setuping SSH Key"

mkdir -p ~/.ssh
echo "$SSH_PRIVATE_KEY" | tr -d '\r' > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa
ssh_host=$(echo $DOKKU_REPO | sed 's/.*@//' | sed 's/[:/].*//')
ssh-keyscan -H "$ssh_host" >> ~/.ssh/known_hosts
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

echo "Pushing to Dokku Host";

git push $DOKKU_REPO HEAD:refs/heads/master --force

[ $? -eq 0 ]  || exit 1

