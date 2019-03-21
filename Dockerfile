FROM nginx:latest

ADD nginx.conf.template /etc/nginx/nginx.conf.template

HEALTHCHECK CMD ls /var/run/nginx.pid

ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
