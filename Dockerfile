FROM sameersbn/debian:jessie.20141001
MAINTAINER sameer@damagehead.com

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10 \
 && echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' > /etc/apt/sources.list.d/mongodb.list \
 && apt-get update \
 && apt-get install -y mongodb-org-server \
 && sed 's/^bind_ip/#bind_ip/' -i /etc/mongod.conf \
 && rm -rf /var/lib/apt/lists/* # 20140918

ADD start /start
RUN chmod 755 /start

EXPOSE 27017
EXPOSE 28017
VOLUME ["/var/lib/mongodb"]

CMD ["/start"]
