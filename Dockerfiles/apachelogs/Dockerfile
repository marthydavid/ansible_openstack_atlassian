FROM alpine
LABEL maintainer="marthy.david@gmail.com"

# install apache
RUN apk --update add apache2 \
    && mkdir /run/apache2/

ENV LOGS_LOCATION "/var/www/localhost/htdocs"
VOLUME $LOGS_LOCATION
EXPOSE 80

COPY httpd.conf /etc/apache2/httpd.conf
COPY ./init.sh /init.sh
RUN chown apache:apache /etc/apache2/httpd.conf
CMD ["sh", "-c", "/init.sh"]
# docker run -d -v /path/to/files:/var/www/localhost/htdocs -p 80:80 apachelogs
#   or, if you want to config log_dir dynamically:
#   docker run ... -e LOGS_LOCATION=/log -v /path/to/files:/log ... apachelogs
