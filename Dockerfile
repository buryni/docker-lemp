FROM ubuntu:14:04
MAINTAINER Buryni buryni@gmail.com

ENV DEBIAN_FRONTEND noninteractive

## Install php nginx supervisor
RUN apt-get update && \
    apt-get install -y php5-fpm php5-cli php5-gd php5-mcrypt php5-mysql php5-curl php5-apcu \
			nginx \
		    supervisor \
	&& curl -sS https://getcomposer.org/installer | php \
	&& rm -rf /var/lib/apt/lists/*

## Configuration
# php-fpm
RUN sed -i 's/^listen\s*=.*$/listen = 127.0.0.1:9000/' /etc/php5/fpm/pool.d/www.conf \
    && sed -i 's/^\;error_log\s*=\s*syslog\s*$/error_log = \/var\/log\/php5\/cgi.log/' /etc/php5/fpm/php.ini \
    && sed -i 's/^\;error_log\s*=\s*syslog\s*$/error_log = \/var\/log\/php5\/cli.log/' /etc/php5/cli/php.ini \
    && mkdir /var/log/php5/ \
    && touch /var/log/php5/cli.log /var/log/php5/cgi.log \
    && chown www-data:www-data /var/log/php5/cgi.log /var/log/php5/cli.log


# nginx
#RUN unlink /etc/nginx/sites-enabled/default
#ADD nginx/default /etc/nginx/sites-enabled/default
#RUN mkdir /var/www/
#ADD nginx/index.php /var/www/
#RUN chown -R www-data:www-data /var/www/

# supervisor
ADD supervisor/php5-fpm.conf /etc/supervisor/conf.d/php5-fpm.conf
ADD supervisor/nginx.conf /etc/supervisor/conf.d/nginx.conf

WORKDIR /var/www/

VOLUME /var/www/
EXPOSE 80

CMD ["/usr/bin/supervisord", "--nodaemon", "-c", "/etc/supervisor/supervisord.conf"]
