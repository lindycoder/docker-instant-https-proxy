HTTPS docker proxy
==================

when in a stack or exposing a port, this container will proxy HTTPS traffic to the same domain it's been called prefixed
by `web.` on the port 80.

here's a setup:

`docker run -it --rm -p 8080:443 dockerhub.binrepo.dev.iweb.com/internap/privatestack.sh-proxy`

will proxy any request to https://domain.privatestack.sh:8080/ to http://web.domain.privatestack.sh/

The target can be defined in a docker network, see the example in `docker-proxy/docker-compose.yml`


# Writing/running tests

Tests uses a self signed certificate so it is tested using --insecure.

`
./test.sh
`

Requires only docker installed.
