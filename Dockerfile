FROM sameersbn/ubuntu:12.04.20140519
MAINTAINER sameer@damagehead.com

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
		echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list && \
		apt-get update && \
		apt-get install -y mongodb-org-server && \
		apt-get clean # 20140418

ADD assets/ /app/
RUN chmod 755 /app/init /app/setup/install
RUN /app/setup/install

ADD authorized_keys /root/.ssh/

EXPOSE 27017
EXPOSE 28017

VOLUME ["/var/lib/mongodb"]

ENTRYPOINT ["/app/init"]
CMD ["app:start"]
