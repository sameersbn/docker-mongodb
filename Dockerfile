FROM sameersbn/ubuntu:12.04.20140628
MAINTAINER sameer@damagehead.com

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
		echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list && \
		apt-get update && \
		apt-get install -y mongodb-org-server && \
		apt-get clean # 20140418

ADD assets/ /app/
RUN chmod 755 /app/init /app/setup/install
RUN /app/setup/install

EXPOSE 27017
EXPOSE 28017

VOLUME ["/var/lib/mongodb"]

CMD chown -R mongodb:mongodb /var/lib/mongodb && \
		sudo -u mongodb -H /usr/bin/mongod --config /etc/mongod.conf --rest
