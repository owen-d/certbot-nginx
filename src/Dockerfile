FROM alpine:latest

LABEL maintainer="owen-d"

RUN apk update && apk add --no-cache nginx curl libressl git socat && \
  mkdir -p /run/nginx

RUN git clone https://github.com/Neilpang/acme.sh.git && \
  cd acme.sh && \
  ./acme.sh --install --home /acme --cert-home /etc/ssl/acme && \
  cd ../ && \
  rm -r acme.sh && \
  sed -i '/acme.sh/d' /etc/crontabs/root && \
  apk del git

RUN curl -L https://github.com/progrium/entrykit/releases/download/v0.4.0/entrykit_0.4.0_Linux_x86_64.tgz | tar -xzvf - -C /usr/local/bin && /usr/local/bin/entrykit --symlink

COPY nginx /etc/nginx
COPY gen-certs.tmpl /usr/local/bin/gen-certs.tmpl
RUN chmod +x /usr/local/bin/gen-certs.tmpl

COPY init-certs.tmpl /usr/local/bin/init-certs.tmpl
RUN chmod +x /usr/local/bin/init-certs.tmpl

COPY cert-reloader.tmpl /usr/local/bin/cert-reloader.tmpl
RUN chmod +x /usr/local/bin/cert-reloader.tmpl

ENTRYPOINT ["render", "/etc/nginx/nginx.conf", "--", \
  "render", "/usr/local/bin/gen-certs", "--", \
  "render", "/usr/local/bin/init-certs", "--", \
  "prehook", "chmod -R +x /usr/local/bin", "--", \
  "prehook", "/usr/local/bin/init-certs", "--", \
  "prehook", "nginx -t", "--", \
  "codep", "/usr/local/bin/cert-reloader", "nginx -g 'daemon off;'"]
