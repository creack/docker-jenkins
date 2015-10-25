FROM            jenkins:latest
MAINTAINER      Guillaume J. Charmes <guillaume@charmes.net>
USER            root
RUN             wget https://get.docker.com/builds/Linux/x86_64/docker-1.8.3 -O /bin/docker && chmod +x /bin/docker
RUN             groupadd -g 999 docker && usermod -aG docker jenkins
USER            jenkins
ENV             PLUGINS "datadog:0.3.0 cobertura:1.9.7 scm-api:0.2 git-client:1.19.0 git:2.4.0 plain-credentials:1.1 github-api:1.69 github:1.14.0 dashboard-view:2.9.6 slack:1.8"
RUN             for plugin in $PLUGINS; do echo $plugin >> /tmp/baseplugins; done; /usr/local/bin/plugins.sh /tmp/baseplugins
#ADD             config.json $JENKINS_HOME/.docker/
#ENV		GIT_SSL_NO_VERIFY	1
