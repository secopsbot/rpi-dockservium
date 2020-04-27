FROM alpine

RUN apk update && apk upgrade
RUN apk add mysql-client mysql

#Add Config
ADD files/etc/mysql/my.cnf /etc/my.cnf

#Cleanup
RUN rm  -rf /tmp/* /var/cache/apk/*

#Add entrypoint
ADD files/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]