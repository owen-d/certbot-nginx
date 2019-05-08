FROM alpine:latest

LABEL maintainer="owen-d"

VOLUME /etc/ssl/acme
ENV CERT_DIR /etc/ssl/acme
EXPOSE 80

RUN apk update && apk add --no-cache nginx curl libressl git socat && \
  mkdir -p /run/nginx

RUN git clone https://github.com/Neilpang/acme.sh.git && \
  cd acme.sh && \
  ./acme.sh --install --home /acme && \
  cd ../ && \
  rm -r acme.sh && \
  sed -i '/acme.sh/d' /etc/crontabs/root && \
  apk del git

RUN curl -L https://github.com/progrium/entrykit/releases/download/v0.4.0/entrykit_0.4.0_Linux_x86_64.tgz | tar -xzvf - -C /usr/local/bin && /usr/local/bin/entrykit --symlink

COPY nginx /etc/nginx

COPY bin /usr/local/bin

ENTRYPOINT [\
  "render", "/etc/nginx/nginx.conf", "--", \
  "render", "/usr/local/bin/gen-certs", "--", \
  "render", "/usr/local/bin/init-certs", "--", \
  "prehook", "chmod -R +x /usr/local/bin", "--", \
  "prehook", "/usr/local/bin/init-certs", "--", \
  "prehook", "nginx -t", "--", \
  "codep", "/usr/local/bin/cert-reloader", "/usr/sbin/nginx" \
]
