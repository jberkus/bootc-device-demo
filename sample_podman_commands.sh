sudo podman build --tag 10.0.1.1:8000/httpd CONTAINERFILE

sudo podman run \
    --rm \
    -it \
    --privileged \
    --pull=newer \
    --security-opt label=type:unconfined_t \
    -v ./config.toml:/config.toml:ro \
    -v ./output:/output \
    -v /var/lib/containers/storage:/var/lib/containers/storage \
    quay.io/centos-bootc/bootc-image-builder:latest \
    --type anaconda-iso \
    --target-arch x86_64 --chown 0:0 --rootfs xfs --use-librepo --verbose \
    10.0.1.1:8000/httpd

podman run --name regproxy --privileged --rm -d \
    -p 8000:8000 \
    -v ~/.local/share/containers/storage/:/var/lib/containers/storage \
    ghcr.io/cgwalters/cstor-dist:latest
