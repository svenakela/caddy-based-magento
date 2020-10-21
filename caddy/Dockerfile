FROM caddy:2.2.0-builder AS builder

RUN xcaddy build \
    --with github.com/hairyhenderson/caddy-teapot-module \
    --with github.com/caddy-dns/cloudflare

FROM caddy:2.2.0

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
