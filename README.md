[![Circle CI](https://circleci.com/gh/sameersbn/docker-mongodb.svg?style=shield)](https://circleci.com/gh/sameersbn/docker-mongodb)

# sameersbn/mongodb

- [Introduction](#introduction)
  - [Contributing](#contributing)
  - [Issues](#issues)
- [Getting started](#getting-started)
  - [Installation](#installation)
  - [Quickstart](#quickstart)
  - [Persistence](#persistence)
  - [Logs](#logs)
- [Maintenance](#maintenance)
  - [Upgrading](#upgrading)
  - [Shell Access](#shell-access)

# Introduction

`Dockerfile` to create a [Docker](https://www.docker.com/) container image for [MongoDB](https://www.mongodb.org/).

MongoDB is a cross-platform document-oriented database. Classified as a NoSQL database, MongoDB eschews the traditional table-based relational database structure in favor of JSON-like documents with dynamic schemas, making the integration of data in certain types of applications easier and faster

## Contributing

If you find this image useful here's how you can help:

- Send a pull request with your awesome features and bug fixes
- Help users resolve their [issues](../../issues?q=is%3Aopen+is%3Aissue).
- Support the development of this image with a [donation](http://www.damagehead.com/donate/)

## Issues

Before reporting your issue please try updating Docker to the latest version and check if it resolves the issue. Refer to the Docker [installation guide](https://docs.docker.com/installation) for instructions.

SELinux users should try disabling SELinux using the command `setenforce 0` to see if it resolves the issue.

If the above recommendations do not help then [report your issue](../../issues/new) along with the following information:

- Output of the `docker version` and `docker info` commands
- The `docker run` command or `docker-compose.yml` used to start the image. Mask out the sensitive bits.
- Please state if you are using [Boot2Docker](http://www.boot2docker.io), [VirtualBox](https://www.virtualbox.org), etc.

# Getting started

## Installation

This image is available as a [trusted build](//hub.docker.com/u/sameersbn/mongodb) on the [Docker hub](//hub.docker.com) and is the recommended method of installation.

```bash
docker pull sameersbn/mongodb:latest
```

Alternatively you can build the image yourself.

```bash
git clone https://github.com/sameersbn/docker-mongodb.git
cd docker-mongodb
docker build --tag $USER/mongodb .
```

## Quickstart

Start MongoDB using:

```bash
docker run --name mongodb -d --restart=always \
  --publish 27017:27017 \
  --volume /srv/docker/mongodb:/var/lib/mongodb \
  sameersbn/mongodb:latest
```

*Alternatively, you can use the sample [docker-compose.yml](docker-compose.yml) file to start the container using [Docker Compose](https://docs.docker.com/compose/)*

> Any arguments specified on the `docker run` command are passed on the `mongod` command.

## Persistence

For MongoDB to preserve its state across container shutdown and startup you should mount a volume at `/var/lib/mongodb`.

> *The [Quickstart](#quickstart) command already mounts a volume for persistence.*

SELinux users should update the security context of the host mountpoint so that it plays nicely with Docker:

```bash
mkdir -p /srv/docker/mongodb
chcon -Rt svirt_sandbox_file_t /srv/docker/mongodb
```

## Logs

To access the MongoDB logs, located at `/var/log/mongodb`, you can use `docker exec`. For example, if you want to tail the logs:

```bash
docker exec -it mongodb tail -f /var/log/mongodb/mongod.log
```

# Maintenance

## Upgrading

To upgrade to newer releases:

  1. Download the updated Docker image:

  ```bash
  docker pull sameersbn/mongodb:latest
  ```

  2. Stop the currently running image:

  ```bash
  docker stop mongodb
  ```

  3. Remove the stopped container

  ```bash
  docker rm -v mongodb
  ```

  4. Start the updated image

  ```bash
  docker run -name mongodb -d \
    [OPTIONS] \
    sameersbn/mongodb:latest
  ```

## Shell Access

For debugging and maintenance purposes you may want access the containers shell. If you are using Docker version `1.3.0` or higher you can access a running containers shell by starting `bash` using `docker exec`:

```bash
docker exec -it mongodb bash
```
