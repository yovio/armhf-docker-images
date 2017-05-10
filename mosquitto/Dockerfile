FROM armhf/alpine:3.5
MAINTAINER Yovi Oktofianus <yovio@hotmail.com>

LABEL Description="Eclipse Mosquitto MQTT Broker for armhf."

RUN apk --no-cache add mosquitto=1.4.10-r2 && \
    mkdir -p /mosquitto/config /mosquitto/data /mosquitto/log && \
    cp /etc/mosquitto/mosquitto.conf /mosquitto/config && \
    chown -R mosquitto:mosquitto /mosquitto

COPY docker-entrypoint.sh /

RUN chmod 700 docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]
