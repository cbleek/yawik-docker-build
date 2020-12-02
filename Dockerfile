FROM php:7.4-apache

MAINTAINER "Carsten Bleek" <bleek@cross-solution.de>

ENV COMPOSER_CACHE_DIR=/var/www/cache/.composer \
	COMPOSER_HOME=$COMPOSER_CACHE_DIR;
	
RUN mkdir -p $COMPOSER_CACHE_DIR;

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - ; \
	apt-get install -y nodejs; \
	curl -sS https://getcomposer.org/installer > installer.php; \
	php ./installer.php --install-dir=/usr/local/bin --filename=composer; \
	chmod +x /usr/local/bin/composer ;

RUN apt-get update && apt-get install -y git-core;


RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
	libicu-dev \
	libssl-dev \
	libcurl4-openssl-dev \
	zip unzip \
   	&& docker-php-ext-install -j$(nproc) intl \
    	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
    	&& docker-php-ext-install -j$(nproc) gd \
	&& pecl install mongodb \
    	&& docker-php-ext-enable mongodb





