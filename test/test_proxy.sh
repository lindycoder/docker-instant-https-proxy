#!/bin/bash -eu

test_http_proxy_header_hides_the_web_prefix() {
    phpinfo=$(${COMPOSE} run --rm curl --insecure https://mydomain.example.org/test/phpinfo.php)
    assert ${?} succeeded

    echo ${phpinfo} | grep web.mydomain.example.org
    assert ${?} failed
}

test_http_proxy_the_forwarded_for() {
    curl_ip=$(${COMPOSE} run -T --rm curl hostname -i)
    assert ${?} succeeded

    echo "Asserting ${curl_ip} is the forwarded for"
    phpinfo=$(${COMPOSE} run --rm curl --insecure https://mydomain.example.org/test/phpinfo.php)
    assert ${?} succeeded

    echo ${phpinfo} | grep "<td class=\"e\">HTTP_X_FORWARDED_FOR </td><td class=\"v\">${curl_ip} </td>"
    assert ${?} succeeded
}

test_http_proxy_the_forwarded_protocol() {
    phpinfo=$(${COMPOSE} run --rm curl --insecure https://mydomain.example.org/test/phpinfo.php)
    assert ${?} succeeded

    echo ${phpinfo} | grep '<td class="e">HTTP_X_FORWARDED_PROTO </td><td class="v">https </td>'
    assert ${?} succeeded
}

test_http_proxy_the_forwarded_host() {
    phpinfo=$(${COMPOSE} run --rm curl --insecure https://mydomain.example.org/test/phpinfo.php)
    assert ${?} succeeded

    echo ${phpinfo} | grep '<td class="e">HTTP_X_FORWARDED_HOST </td><td class="v">mydomain.example.org </td>'
    assert ${?} succeeded
}
