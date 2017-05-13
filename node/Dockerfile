FROM yovio/armhf-alpine:latest
MAINTAINER Yovi Oktofianus <yovio@hotmail.com>

LABEL Description="NodeJs for armhf."

RUN adduser -D -u 1000 node \
    && apk add --no-cache nodejs=6.9.5-r0

CMD ["node"]
