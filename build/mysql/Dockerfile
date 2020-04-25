FROM alpine

RUN apk update && apk upgrade --force-overwrite
RUN apk add mysql-client mysql

#Cleanup
RUN rm  -rf /tmp/* /var/cache/apk/*

#Add Config
ADD files/etc/mysql/my.cnf /etc/my.cnf

#Add entrypoint
ADD files/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]