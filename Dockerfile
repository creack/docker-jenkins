FROM            ubuntu:14.04
MAINTAINER      Guillaume J. Charmes <guillaume@charmes.net>

# Install utils
RUN             apt-get update && apt-get install -y curl wget git unzip && apt-get clean

# Install Jenkins
RUN             curl http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -

#RUN echo deb http://archive.ubuntu.com/ubuntu precise universe >> /etc/apt/sources.list

RUN             echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list

#RUN mkdir /var/run/jenkins

RUN             apt-get update && apt-get install -y jenkins && apt-get clean

# Install Docker
RUN             wget -q https://get.docker.io/builds/Linux/x86_64/docker-latest -O /usr/local/bin/docker && \
                chmod +x /usr/local/bin/docker

# Install Jenkins plugins
ENV             JENKINS_PLUGINS         scm-api git git-client
RUN             mkdir /tmp/plugins
RUN             cd /tmp/plugins && \
                for plugin in $JENKINS_PLUGINS; do \
                    echo Installing $plugin; \
                    wget -q http://updates.jenkins-ci.org/latest/$plugin.hpi; \
                done


# Set basic env
ENV             HOME            /root
ENV             JENKINS_HOME    /var/lib/jenkins/.jenkins
#ENV		PATH		$PATH:/usr/local/bin

EXPOSE          8080

#VOLUME         ["/var/lib/jenkins"]

CMD             mkdir -p $JENKINS_HOME/plugins && \
                cp /tmp/plugins/* $JENKINS_HOME/plugins/ && \
                chown -R jenkins $JENKINS_HOME && \
                java -jar /usr/share/jenkins/jenkins.war

#CMD            ["java", "-jar", "/usr/share/jenkins/jenkins.war"]
ENV		GIT_SSL_NO_VERIFY	1
