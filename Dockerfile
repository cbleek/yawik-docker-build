FROM ubuntu:20.04

MAINTAINER "Carsten Bleek" <bleek@cross-solution.de>

ENV COMPOSER_CACHE_DIR=/var/www/cache/.composer \
    COMPOSER_HOME=$COMPOSER_CACHE_DIR \
    DEBIAN_FRONTEND=noninteractive;
	
RUN mkdir -p $COMPOSER_CACHE_DIR;

RUN apt-get update && \
        apt-get -yq install curl git zip unzip; \
        curl -sL https://deb.nodesource.com/setup_12.x | bash - ; \
	apt-get install -y nodejs \
	php-fpm \
	php-gd \
	php-intl \
	php-mongodb \
	php;\
	curl -sS https://getcomposer.org/installer > installer.php; \
	php ./installer.php --install-dir=/usr/local/bin --filename=composer; \
	chmod +x /usr/local/bin/composer ;






