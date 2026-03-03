openssl req \
    -newkey rsa:4096 \
    -nodes \
    -sha256 \
    -keyout "setup/domain.key" \
    -addext "subjectAltName = IP:10.0.1.1" \
    -x509 \
    -days 365 \
    -out "setup/domain.crt" \
    -subj "/C=US/ST=Denial/L=Stockholm/O=bootc/OU=bootc-test/CN=bootc-test/emailAddress=bootc-test@bootc-test.org"

sudo cp "setup/domain.crt" "/etc/pki/ca-trust/source/anchors/10.0.1.1.crt"
sudo update-ca-trust

podman run \
    -d \
    --name registry \
    --replace \
    --network host \
    -v ./setup:/certs:z \
    -e REGISTRY_HTTP_ADDR="10.0.1.1:8000" \
    -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
    -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
    quay.io/bootc-test/registry:2.8.3
