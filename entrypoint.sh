#!/bin/sh -l

script_dir=$(dirname $0)

. "$script_dir/setup-ssh.sh"

echo ""
echo "Pushing to Dokku Host";

git push $DOKKU_REPO $GITHUB_SHA:refs/heads/$DEPLOY_BRANCH --force

[ $? -eq 0 ]  || exit 1

