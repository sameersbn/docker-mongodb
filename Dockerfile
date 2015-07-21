FROM sameersbn/ubuntu:14.04.20150712
MAINTAINER sameer@damagehead.com

ENV MONGO_USER=mongodb \
    MONGO_DATA_DIR=/var/lib/mongodb

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10 \
 && echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' > /etc/apt/sources.list.d/mongodb.list \
 && apt-get update \
 && apt-get install -y mongodb-org-server \
 && sed 's/^bind_ip/#bind_ip/' -i /etc/mongod.conf \
 && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 27017/tcp 28017/tcp
VOLUME ["/var/lib/mongodb"]
ENTRYPOINT ["/sbin/entrypoint.sh"]
