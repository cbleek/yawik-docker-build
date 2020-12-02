FROM ubuntu:20.04

MAINTAINER "Carsten Bleek" <bleek@cross-solution.de>

ENV COMPOSER_CACHE_DIR=/var/www/cache/.composer \
    COMPOSER_HOME=$COMPOSER_CACHE_DIR \
    DEBIAN_FRONTEND=noninteractive;
	
RUN mkdir -p $COMPOSER_CACHE_DIR;

RUN apt update && \
        apt -yq install curl git zip unzip; \
        curl -sL https://deb.nodesource.com/setup_12.x | bash - ; \
	apt install -y nodejs \
	php7.4-fpm \
	php7.4-common \
	php7.4-cli \
	php7.4-gd \
	php7.4-intl \
	php7.4-dev \
	php7.4;\
	pecl install mongodb; \
	phpenmod mongodb; \
	curl -sS https://getcomposer.org/installer > installer.php; \
	php ./installer.php --install-dir=/usr/local/bin --filename=composer; \
	chmod +x /usr/local/bin/composer ;






