FROM obrassard/alpine-git-ssh:latest
COPY ./entrypoint.sh /app/entrypoint.sh
COPY ./dokku-unlock.sh /app/dokku-unlock.sh
COPY ./setup-ssh.sh /app/setup-ssh.sh
RUN chmod +x /app/*.sh
