[![Circle CI](https://circleci.com/gh/sameersbn/docker-mongodb.svg?style=shield)](https://circleci.com/gh/sameersbn/docker-mongodb) [![Docker Repository on Quay.io](https://quay.io/repository/sameersbn/mongodb/status "Docker Repository on Quay.io")](https://quay.io/repository/sameersbn/mongodb)

> **NOTICE**:
>
> Active maintenance of the image has been halted. Your [contributions](#contributing) are welcome.

# sameersbn/mongodb:latest

- [Introduction](#introduction)
  - [Contributing](#contributing)
  - [Issues](#issues)
- [Getting started](#getting-started)
  - [Installation](#installation)
  - [Quickstart](#quickstart)
  - [Command-line arguments](#command-line-arguments)
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

Automated builds of the image are available on [Dockerhub](https://hub.docker.com/r/sameersbn/mongodb) and is the recommended method of installation.

> **Note**: Builds are also available on [Quay.io](https://quay.io/repository/sameersbn/mongodb)

```bash
docker pull sameersbn/mongodb:latest
```

Alternatively you can build the image yourself.

```bash
docker build -t sameersbn/mongodb github.com/sameersbn/docker-mongodb
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

## Command-line arguments

You can customize the launch command of the MongoDB server by specifying arguments to `mongod` on the `docker run` command. For example the following command prints the help menu of `mongod` command:

```bash
docker run --name mongodb -it --rm \
  --publish 27017:27017 \
  --volume /srv/docker/mongodb:/var/lib/mongodb \
  sameersbn/mongodb:latest --help
```

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
## Host UID / GID Mapping
Per default the container is configured to run mongodb as user and group `mongodb` with `uid` `102` and `gid` `65534`. The host possibly uses this ids for different purposes leading to unfavorable effects. From the host it appears as if the mounted data volumes are owned by the host's user `102 and group `65534`.

Also the container processes seem to be executed as this host's user/group. The container can be configured to map the `uid` and `gid` of `mongodb` to different ids on host by passing the environment variables `USERMAP_UID` and `USERMAP_GID`. The following command maps the ids to user and group `mongodb` on the host.

```bash
docker run --name mongodb -it --rm [options] \
    --env "USERMAP_UID=$(id -u mongodb)" --env "USERMAP_GID=$(id -g mongodb)" \
    sameersbn/mongodb:latest
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
