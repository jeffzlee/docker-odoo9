FROM debian:jessie

ENV GOSU_VERSION 1.7
RUN set -x \
	&& apt-get update && apt-get install -y --no-install-recommends ca-certificates wget && rm -rf /var/lib/apt/lists/* \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true \
	&& apt-get purge -y --auto-remove ca-certificates wget

# Execution environment 
# USER 0 # Copy entrypoint script , Odoo Service script and Odoo configuration file 
COPY ./entrypoint1.sh /
COPY ./openerp-server.conf /etc/

# COPY /opt/odoo/openerp-server /etc/init.d/
#COPY ./openerp-server /etc/init.d/
#RUN chown odoo:odoo /etc/openerp-server.conf
#RUN chmod 640 /etc/openerp-server.conf
#RUN chmod 755 /etc/init.d/openerp-server
#RUN chown root: /etc/init.d/openerp-server
# Create service sudo service odoo-server start 
# RUN update-rc.d openerp-server defaults
# Start odoo service 
# RUN service openerp-server status
# Mount /opt/odoo to allow restoring filestore and /mnt/extra-addons for users addons 
RUN mkdir -p /mnt/extra-addons 
# \
#        && chown -R odoo /mnt/extra-addons
VOLUME ["/opt/odoo", "/mnt/extra-addons"]
# Expose Odoo services 
EXPOSE 8069 8071 
# Set the default config file 
ENV OPENERP_SERVER /etc/openerp-server.conf 
# Set default user when running the container 
#USER odoo 
ENTRYPOINT ["/entrypoint1.sh"]
#CMD ["/opt/odoo/openerp-server"]
