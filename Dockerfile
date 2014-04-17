FROM sameersbn/ubuntu:latest
MAINTAINER sameer@damagehead.com

# image specific
RUN apt-get install -y mongodb && apt-get clean

ADD assets/ /app/
RUN chmod 755 /app/init /app/setup/install && /app/setup/install

ADD authorized_keys /root/.ssh/

EXPOSE 22
EXPOSE 27017
EXPOSE 28017

VOLUME ["/var/lib/mongodb"]

ENTRYPOINT ["/app/init"]
CMD ["app:start"]
