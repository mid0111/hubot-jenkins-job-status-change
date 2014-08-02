# DOCKER-VERSION 0.11.1
# VERSION 0.0.1

FROM tutum/centos-6.4:latest

MAINTAINER mid0111

# sysconfig network
RUN echo "NETWORKING=yes" > /etc/sysconfig/network

RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
# yum
RUN yum update -y
RUN yum install -y passwd
RUN yum install -y sudo
RUN yum install -y gcc
RUN yum install -y gcc-c++
RUN yum install -y make
RUN yum install -y vim
RUN yum install -y git
RUN yum install --enablerepo=epel -y mosh
RUN yum install -y openssl-devel
RUN yum install -y zlib-devel
RUN yum install -y readline-devel
RUN yum install -y bzip2-devel
RUN yum install -y libevent-devel
RUN yum install -y openssh
RUN yum install -y openssh-server
RUN yum install -y openssh-clients
RUN yum install -y cmake
RUN yum install -y npm
RUN yum install -y redis
RUN yum install -y java-1.7.0-openjdk java-1.7.0-openjdk-devel

# ssh
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config

# user
RUN useradd mid
RUN echo 'mid' | passwd --stdin mid
RUN echo 'export PS1='\''\[\033[01;34m\]\W\[\033[00m\] % '\''' >> /home/mid/.bashrc

# sudo
RUN echo 'mid ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/mid

# timezone
RUN cp -p /usr/share/zoneinfo/Japan /etc/localtime

# sshd
RUN /etc/init.d/sshd start
RUN /etc/init.d/sshd stop

# redis
RUN /etc/init.d/redis start
RUN chkconfig redis on

# npm
## coffee-script
RUN npm install -g coffee-script

# jenkins
RUN wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
RUN rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
RUN yum install -y jenkins
RUN cp -p /etc/sysconfig/jenkins /etc/sysconfig/jenkins.org
RUN sed -e 's%JENKINS_ARGS=""%JENKINS_ARGS="--prefix=/jenkins --httpPort=${JENKINS_PORT} --ajp13Port=${JENKINS_AJP_PORT}"%g' -i /etc/sysconfig/jenkins
RUN /etc/init.d/jenkins start
RUN chkconfig jenkins on

## hubot
RUN npm install -g hubot
RUN hubot --create myhubot

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
