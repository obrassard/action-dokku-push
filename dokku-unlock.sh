#!/bin/sh -l

script_dir=$(dirname $0)

. "$script_dir/setup-ssh.sh"

echo ""
echo "Unlocking Dokku deployment";

app=$(echo $DOKKU_REPO | sed -e 's/.*\///')
ssh -p ${ssh_port:=22} dokku@$ssh_host apps:unlock $app