FROM php:7.4

LABEL maintainer='"Carsten Bleek" <bleek@cross-solution.de>'

ENV COMPOSER_CACHE_DIR=/var/www/cache/.composer
ENV COMPOSER_HOME=$COMPOSER_CACHE_DIR
ENV DEBIAN_FRONTEND=noninteractive

# update and install things we allways need	
RUN useradd -ms /bin/bash -d /app yawik;\
    mkdir -p $COMPOSER_CACHE_DIR; \
    apt-get update; \
    apt-get -yq install \
    	curl git zip unzip nginx joe gnupg2 libxi6 libgconf-2-4 \
    	libcurl4-openssl-dev \
    	libxml2-dev \
    	python3-pip \
    	zlib1g-dev;

# Install Nodes
RUN  curl -sL https://deb.nodesource.com/setup_12.x | bash - ; \
     apt-get -y install nodejs;

# Install deployer
RUN curl -sLO https://deployer.org/deployer.phar; \
	chmod +x deployer.phar; \
	mv deployer.phar /usr/local/bin/dep;

RUN docker-php-ext-install intl;

# packages
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  # needed for gd
  libfreetype6-dev \
  libjpeg62-turbo-dev \
  libpng-dev \
  && rm -rf /var/lib/apt/lists/*

# GD
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install -j "$(nproc)" gd

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
	
# Install mkdocs
RUN pip3 install mkdocs; \
	pip3 install mkdocs-material;

COPY checkout-yawik.sh /app/checkout-yawik.sh

CMD ["nginx", "-g", "daemon off;"]
