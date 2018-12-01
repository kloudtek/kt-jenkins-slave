FROM ubuntu:18.04

ARG user=jenkins
ARG group=jenkins
ARG uid=10000
ARG gid=10000
ARG VERSION=3.27
ARG AGENT_WORKDIR=/home/${user}/agent

ENV LANG=C.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL=C.UTF-8

ENV HOME /home/${user}

COPY setup.sh /sbin/setupimg
COPY jenkins-slave.sh /usr/bin/jenkins-slave
RUN bash /sbin/setupimg

USER ${user}

ENV AGENT_WORKDIR=${AGENT_WORKDIR}
RUN mkdir /home/${user}/.jenkins && mkdir -p ${AGENT_WORKDIR}

VOLUME /home/${user}/.jenkins
VOLUME ${AGENT_WORKDIR}
WORKDIR /home/${user}

ENTRYPOINT ["/usr/bin/jenkins-slave"]