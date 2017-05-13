FROM yovio/armhf-node

# Home directory for Node-RED application source code.
RUN mkdir -p /usr/src/node-red \
	# User data directory, contains flows, config and nodes.
	&& mkdir /data \
	# Add node-red user so we aren't running as root.
	&& adduser -D -h /usr/src/node-red -H node-red \
    && chown -R node-red:node-red /data \
    && chown -R node-red:node-red /usr/src/node-red

WORKDIR /usr/src/node-red
USER node-red

RUN npm install --unsafe-perm node-red

# User configuration directory volume
EXPOSE 1880

# Environment variable holding file path for flows configuration
ENV FLOWS=flows.json

CMD ["npm", "start", "--", "--userDir", "/data"]
