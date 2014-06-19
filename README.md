docker-jenkins
==============

Jenkins in Docker with Git plugin and Docker installed


Usage
=====

Ephemeral:

`docker run -d -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock creack/docker-jenkins`

Persistent

`docker run -d -p 8080:8080 -v $(pwd)/jenkins:/var/lib/jenkins -v /var/run/docker.sock:/var/run/docker.sock creack/docker-jenkins`
