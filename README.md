nginx-php
=========

Use at your own risk.

# Usage

    docker run -d --name=nginx-php \
      -v /path/to/www/:/var/www/ \
      -p port_of_nginx:80 \
      buryni/nginx-php:latest

# Details

## VERSIONS
* SO: Ubuntu Server 14.04
* WEB-SERVER: Nginx 
* PHP: 

## SSH

Use `docker exec` to enter the docker container.
