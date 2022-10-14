# syntax=docker/dockerfile:1.4
FROM jenkins/jenkins:lts
USER root
RUN apt-get update && apt-get install -y lsb-release
RUN <<EOF
curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc https://download.docker.com/linux/debian/gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
EOF
RUN <<EOF1
apt-get update
apt-get install -y docker-ce-cli
rm -rf /var/lib/apt/lists/*
EOF1
USER jenkins
RUN jenkins-plugin-cli --plugins "docker-workflow:521.v1a_a_dd2073b_2e"