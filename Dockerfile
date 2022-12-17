FROM obrassard/alpine-git-ssh:latest
COPY ./entrypoint.sh /app/entrypoint.sh
COPY ./dokku-unlock.sh /app/dokku-unlock.sh
COPY ./setup-ssh.sh /app/setup-ssh.sh
COPY ./cloudflared.sh /app/cloudflared.sh
RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /usr/local/bin/cloudflared
RUN chmod +x /usr/local/bin/cloudflared
RUN chmod +x /app/*.sh
