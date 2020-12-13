FROM ubuntu:20.04

LABEL maintainer='"Carsten Bleek" <bleek@cross-solution.de>'

ENV COMPOSER_CACHE_DIR=/var/www/cache/.composer
ENV COMPOSER_HOME=$COMPOSER_CACHE_DIR
ENV DEBIAN_FRONTEND=noninteractive

# update and install things we allways need	
RUN useradd -ms /bin/bash yawik;\
    mkdir -p $COMPOSER_CACHE_DIR; \
    apt-get update; \
    apt-get -yq install curl git zip unzip nginx joe;

RUN  curl -sL https://deb.nodesource.com/setup_12.x | bash - ; \
     apt-get install nodejs;

# we use the google version, because ubuntu version requires snap.
RUN curl -LO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb; \
	apt-get install -y ./google-chrome-stable_current_amd64.deb; \
	rm google-chrome-stable_current_amd64.deb;



RUN  apt-get update; apt-get install -y openjdk-14-jre-headless \
	chromium-chromedriver \
	php7.4-fpm \
	php7.4-common \
	php7.4-cli \
	php7.4-gd \
	php7.4-curl \
	php7.4-intl \
	php7.4-mbstring \
	php7.4-dev \
	php-solr \
	php7.4;

run pecl install mongodb; \
	echo "extension=mongodb.so" > /etc/php/7.4/mods-available/mongodb.ini; \
	phpenmod mongodb; \
	curl -sS https://getcomposer.org/installer > installer.php; \
	php ./installer.php --install-dir=/usr/local/bin --filename=composer; \
	chmod +x /usr/local/bin/composer;

COPY checkout-yawik.sh /home/yawik/checkout-yawik.sh

CMD ["nginx", "-g", "daemon off;"]
