FROM nginx:1.28.0-alpine

RUN apk update && \
  apk add bash && \
  rm -f /etc/nginx/conf.d/*.conf

COPY nginx.conf /etc/nginx/nginx.conf
COPY site.conf /etc/nginx/conf.d/site.conf