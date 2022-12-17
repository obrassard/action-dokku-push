# action-dokku-deploy@cloudflared
Easily deploy an app to your Dokku Instance from GitHub **through Cloudflare Tunnel** !.

For a version without Cloudflare Tunnel support, see the `main` branch.

### Requirements

Please note that this action is compatible with `dokku >= 0.11.6`.

### Prerequisites

You must create a new Service Token in Cloudflare Zero Trust Dashboard and add the clientID/clientSecret to your GitHub Secrets.
See https://developers.cloudflare.com/cloudflare-one/tutorials/ssh-service-token to learn how to create a Service Token.


## Inputs

#### `dokku_repo`

**Required**. The dokku app's git repository url **(in SSH format)**. 

Example : `ssh://dokku@dokku.myhost.ca:22/appname`

***

#### `ssh_key`

**Required**. An private ssh key that has push acces to your Dokku instance. 

Example :

```
-----BEGIN OPENSSH PRIVATE KEY-----
MIIEogIBAAKCAQEAjLdCs9kQkimyfOSa8IfXf4gmexWWv6o/IcjmfC6YD9LEC4He
qPPZtAKoonmd86k8jbrSbNZ/4OBelbYO0pmED90xyFRLlzLr/99ZcBtilQ33MNAh
...
SvhOFcCPizxFeuuJGYQhNlxVBWPj1Jl6ni6rBoHmbBhZCPCnhmenlBPVJcnUczyy
zrrvVLniH+UTjreQkhbFVqLPnL44+LIo30/oQJPISLxMYmZnuwudPN6O6ubyb8MK
-----END OPENSSH PRIVATE KEY-----

```

> :bulb: Tip : It is recommanded to use **GitHub Actions Secrets** to store sensible informations like SSH Keys

***

#### `deploy_branch`

Optional. The branch to be deployed when pushing to Dokku (default to `master`). Useful when a [custom deploy branch](http://dokku.viewdocs.io/dokku/deployment/methods/git/#changing-the-deploy-branch) is set on Dokku.

Example : `develop`

### `cloudflared_client_id`

**Required**. The clientID of the Service Token created in Cloudflare Zero Trust Dashboard.

Example : `a61c032ee4510f8b7e2749ea0896cc14.access`

### `cloudflared_client_secret`

**Required**. The clientID of the Service Token created in Cloudflare Zero Trust Dashboard.

Example : `85dcb2301975e8b8e40deb6097645995aa4bed35c2badf098028652097c69eeb`


## Example usage 

This action is particularly useful when triggered by new pushes :

```yml
name: 'Deploy to my Dokku instance'

on:
  push:
    branches:
    - main

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
  
    - name: Cancel Previous Runs # Optional step 
      uses: styfle/cancel-workflow-action@0.4.0
      with:
        access_token: ${{ github.token }}
    
    - name: Cloning repo # This step is required
      uses: actions/checkout@v2
      with:
        fetch-depth: 0 # This is required or you might get an error from Dokku

    - name: Push to dokku
      uses: obrassard/action-dokku-deploy@cloudflared # This version tag is required for Cloudflare Tunnel support
      with:
        dokku_repo: 'ssh://dokku@dokku.myhost.ca:22/appname'
        ssh_key: ${{ secrets.SSH_KEY }}
        deploy_branch: 'develop'
        cloudflared_client_id: ${{ secrets.CLOUDFLARED_CLIENT_ID }}
        cloudflared_client_secret: ${{ secrets.CLOUDFLARED_CLIENT_SECRET }}
```

