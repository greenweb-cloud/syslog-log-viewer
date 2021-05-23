FROM ubuntu

ENV TZ=Asia/Tehran
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update \
    && apt-get install -yqq git nginx rsyslog supervisor php-fpm php-cli apache2-utils\
    && rm -rf /var/lib/apt/lists/*

RUN sed -i '1idaemon off;' /etc/nginx/nginx.conf

RUN rm -rf /var/www && git clone https://github.com/potsky/PimpMyLog.git /var/www
RUN sed -i -e 's/;daemonize\ =\ yes/daemonize\ =\ no/' /etc/php/7.4/fpm/php-fpm.conf
RUN sed -i 's/^variables_order\ =.*/variables_order\ =\ \"GPCSE\"'/ /etc/php/7.4/fpm/php.ini
RUN sed -i 's/^variables_order\ =.*/variables_order\ =\ \"GPCSE\"'/ /etc/php/7.4/cli/php.ini

RUN mkdir -p /var/log/net/ && touch /var/log/net/syslog.log && ln -s /var/log/net/syslog.log /var/www/
RUN chown -R syslog:adm /var/log/net/
RUN adduser www-data adm

COPY nginx-default /etc/nginx/sites-enabled/default
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY config.user.php /var/www/
COPY rsyslog.conf /etc/rsyslog.conf
COPY create-user.php /var/www/
COPY run.sh /

EXPOSE 80 514/udp

CMD ["/run.sh"]
