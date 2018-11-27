#!/bin/bash

chmod +x /usr/bin/jenkins-slave

export DEBIAN_FRONTEND=noninteractive
curl https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
sudo apt-add-repository "deb https://deb.nodesource.com/node_7.x $(lsb_release -sc) main"
apt-get update
apt-get install -yq openjdk-8-jdk curl nodejs npm git maven
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