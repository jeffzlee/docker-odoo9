FROM debian:jessie

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
