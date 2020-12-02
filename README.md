docker image
============

Simple container with php7.4, composer, npm based on ubuntu 20.04. It's used
to run phpunit and behat tests. Pushes to the master trigger the build of

https://hub.docker.com/repository/docker/yawik/build

Requirements
------------

- docker
- docker-composer

Installation
------------

<pre>
git clone https://github.com/cross-solution/yawik-docker-builf
cd yawik-docker-build
docker-composer up
</pre>

Status
------

work in progress. Image is not ready for work.

License
-------

MIT