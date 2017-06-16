FROM yovio/armhf-alpine:latest
MAINTAINER Yovi Oktofianus <yovio@hotmail.com>

LABEL Description="Python2 for armhf."

RUN apk add --no-cache python2 \
		python-dev \
		py-pip \
		build-base \
	&& pip install virtualenv

CMD ["python2"]
