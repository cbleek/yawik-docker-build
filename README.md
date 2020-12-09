docker image
============

Simple container based on ubuntu 20.04 containing everything to run yawik,
phpunit and behat tests. It's used to run phpunit and behat tests. It contains:

- php7.4
- java
- composer
- npm
- google chome
- mongo
- nginx

In addition a unprivileged user `yawik` is created. 

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
git clone https://github.com/cross-solution/yawik-docker-builf
cd yawik-docker-build
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
