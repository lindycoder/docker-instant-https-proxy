FROM nginx:latest

ADD nginx.conf.template /etc/nginx/nginx.conf.template
#ADD ssl/ /etc/nginx/certs/
#
#RUN chown 0600 /etc/nginx/certs/ssl*

HEALTHCHECK CMD ls /var/run/nginx.pid

ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
