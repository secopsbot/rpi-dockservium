FROM alpine

RUN apk -U upgrade
RUN apk add supervisor incron
RUN apk add subversion rrdtool mtr imagemagick graphviz fping python nmap
RUN apk add apache2 mysql-client php7-mysqli php7-json php7-pear php7-pecl-mcrypt php7-ctype php7-session php7-apache2 ttf-dejavu
RUN apk add net-snmp net-snmp-tools 

# Observium installation can be community, stable, current NOTE: stable,current require a valid subscription.

# Observium > Install (community) - default
RUN wget http://www.observium.org/observium-community-latest.tar.gz -O /tmp/observium-community-latest.tar.gz
RUN tar zxf /tmp/observium-community-latest.tar.gz -C /opt/
RUN rm -f /tmp/observium-community-latest.tar.gz

# Observium > Install (stable train) - untested
#RUN svn co --username $SVN_USERNAME --password $SVN_PASSWORD http://svn.observium.org/svn/observium/branches/stable /opt/observium

# Observium > Install (current train) - untested
#RUN svn co --username $SVN_USERNAME --password $SVN_PASSWORD http://svn.observium.org/svn/observium/trunk /opt/observium

# Observium > Configure
RUN cp -f /opt/observium/config.php.default /opt/observium/config.php
RUN sed -e 's/localhost/mysql/' -i /opt/observium/config.php
RUN sed -e 's/USERNAME/observium/' -i /opt/observium/config.php
RUN sed -e 's/PASSWORD/observium/' -i /opt/observium/config.php
RUN mkdir -p /opt/observium/rrd
RUN mkdir -p /opt/observium/logs
RUN ln -s /usr/sbin/fping /usr/bin/fping
RUN ln -s /usr/sbin/mtr /usr/bin/mtr

# Apache > Configure
RUN sed -i '/mod_rewrite.*/s/^#//g' /etc/apache2/httpd.conf
ADD files/etc/apache2/conf.d/observium.conf /etc/apache2/conf.d/observium.conf

# Cron > Configure
ADD files/etc/crontabs/root /etc/crontabs/root
RUN chmod 700 /etc/crontabs/root

# Supervisor > Configure
ADD files/etc/supervisord.conf /etc/supervisord.conf

# apk > Clean-up
#RUN rm  -rf /tmp/* /var/cache/apk/*

# Add observium bootstrap script
ADD files/observium-bootstrap.sh /opt/observium-bootstrap.sh
RUN chmod 700 /opt/observium-bootstrap.sh

EXPOSE 80

ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]