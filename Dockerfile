FROM ubuntu:20.04

LABEL maintainer='"Carsten Bleek" <bleek@cross-solution.de>'


ENV COMPOSER_CACHE_DIR=/var/www/cache/.composer
ENV COMPOSER_HOME=$COMPOSER_CACHE_DIR
ENV DEBIAN_FRONTEND=noninteractive
	
RUN useradd -ms /bin/bash yawik;\
    mkdir -p $COMPOSER_CACHE_DIR;

RUN apt-get update && \
        apt-get -yq install curl git zip unzip nginx joe; \
        curl -sL https://deb.nodesource.com/setup_12.x | bash - ; \
	apt-get install -y nodejs \
	openjdk-14-jre-headless \
	php7.4-fpm \
	php7.4-common \
	php7.4-cli \
	php7.4-gd \
	php7.4-curl \
	php7.4-intl \
	php7.4-mbstring \
	php7.4-dev \
	php7.4;\
	pecl install mongodb; \
	echo "extension=mongodb.so" > /etc/php/7.4/mods-available/mongodb.ini; \
	phpenmod mongodb; \
	curl -sS https://getcomposer.org/installer > installer.php; \
	php ./installer.php --install-dir=/usr/local/bin --filename=composer; \
	chmod +x /usr/local/bin/composer;

CMD ["nginx", "-g", "daemon off;"]
