FROM php:7.4

LABEL maintainer='"Carsten Bleek" <bleek@cross-solution.de>'

ENV COMPOSER_CACHE_DIR=/var/www/cache/.composer
ENV COMPOSER_HOME=$COMPOSER_CACHE_DIR
ENV DEBIAN_FRONTEND=noninteractive

# update and install things we allways need	
RUN useradd -ms /bin/bash yawik;\
    mkdir -p $COMPOSER_CACHE_DIR; \
    apt-get update; \
    apt-get -yq install \
    	curl git zip unzip nginx joe gnupg2 libxi6 libgconf-2-4 \
    	libcurl4-openssl-dev \
    	libxml2-dev \
        libpng-dev \
    	zlib1g-dev;


#RUN apt-get -yq install software-properties-common;
#	add-apt-repository ppa:linuxuprising/java;\
#	apt-get update;
#	apt-get -yq install oracle-java11-installer;



# Install Nodes
RUN  curl -sL https://deb.nodesource.com/setup_12.x | bash - ; \
     apt-get -y install nodejs;

# Install deployer
RUN curl -sLO https://deployer.org/deployer.phar; \
	chmod +x deployer.phar; \
	mv deployer.phar /usr/local/bin/dep;


RUN docker-php-ext-install intl gd;


#RUN curl -LO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb; \
#	apt-get install -y ./google-chrome-stable_current_amd64.deb; \
#	rm google-chrome-stable_current_amd64.deb;

# Intall PHP and extensions
#RUN  apt-get update; apt-get install -y openjdk-14-jre-headless \
#	chromium-chromedriver;

# Install PHP mongodb extension
RUN pecl install mongodb; \
	echo "extension=mongodb.so" > /usr/local/etc/php/conf.d/mongodb.ini;

# Install PHP solr extension
RUN pecl install solr; \
	echo "extension=solr.so" > /usr/local/etc/php/conf.d/solr.ini;

# Install composer
RUN curl -sS https://getcomposer.org/installer > installer.php; \
	php ./installer.php --install-dir=/usr/local/bin --filename=composer; \
	chmod +x /usr/local/bin/composer;

COPY checkout-yawik.sh /home/yawik/checkout-yawik.sh

CMD ["nginx", "-g", "daemon off;"]
