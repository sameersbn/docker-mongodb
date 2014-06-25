FROM sameersbn/ubuntu:12.04.20140519
MAINTAINER sameer@damagehead.com

RUN apt-get update && \
		apt-get install -y mongodb && \
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
