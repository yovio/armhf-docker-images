ARG MOSQUITTO_VER=1.4.10-r2
FROM yovio/armhf-alpine:latest
MAINTAINER Yovi Oktofianus <yovio@hotmail.com>

LABEL Description="Eclipse Mosquitto MQTT Broker for armhf."

RUN apk --no-cache add mosquitto=${MOSQUITTO_VER} && \
    mkdir -p /mosquitto/config /mosquitto/data /mosquitto/log && \
    cp /etc/mosquitto/mosquitto.conf /mosquitto/config && \
    chown -R mosquitto:mosquitto /mosquitto

COPY docker-entrypoint.sh /

RUN chmod 700 docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]
