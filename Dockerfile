FROM obrassard/alpine-git-ssh:latest
COPY ./entrypoint.sh /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]