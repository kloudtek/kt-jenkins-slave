#!/bin/bash

set -e

chmod +x /usr/bin/jenkins-slave

export DEBIAN_FRONTEND=noninteractive
apt-get update

# Update timezone

apt-get install -yq tzdata && true

ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
dpkg-reconfigure -f noninteractive tzdata

# Update locales

apt-get install -yq locales && true

# Install other packages

apt-get install -yq curl openjdk-8-jdk curl nodejs npm git gpg

# Configure user

echo "Creating group ${group} with GUID ${gid}"
addgroup --gid ${gid} ${group}
adduser --home $HOME --uid ${uid} --ingroup ${group} --disabled-password --gecos "" ${user}

echo "Installing jenkins slave"

mkdir -p /usr/share/jenkins
apt-get install -yq
curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${VERSION}/remoting-${VERSION}.jar
chmod 755 /usr/share/jenkins
chmod 644 /usr/share/jenkins/slave.jar

echo "ng"

npm install -g ng-cli
