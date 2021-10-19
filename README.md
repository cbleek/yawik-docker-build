docker image
============

Simple container based on [php:8.0](https://hub.docker.com/_/php) containing 
everything to run yawik, phpunit and behat tests. It's used to run phpunit and 
behat tests. It contains:

- php8.0
- composer
- npm
- php-mongodb > 1.9
- php-solr > 2.5
- nginx
- pip3
- mkdocs

In addition a unprivileged user `yawik` is created. 

The docker container links a [mongo:4.4](https://hub.docker.com/_/mongo) and a 
[selenium](https://hub.docker.com/r/selenium/standalone-chrome/) container.

Pushes to the master trigger the build of

https://hub.docker.com/repository/docker/yawik/build

Requirements
------------

- [docker](https://docs.docker.com/get-docker/)
- [docker-composer](https://docs.docker.com/compose/)

Installation
------------

you can build and run the docker container by:

<pre>
git clone https://gitlab.com/yawik/docker/build.git
cd build
docker-composer up
</pre>

after the container was build and started, you can enter it with `docker exec -it php
/bin/bash`

<pre>
root@docker:~# docker exec -it php /bin/bash
root@php:/# su - yawik
yawik@php:~$ ./checkout-yawik.sh
</pre>



Status
------

work in progress. Image is used in CI/CD.

License
-------

MIT
