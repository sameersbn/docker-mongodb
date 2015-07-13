[![Circle CI](https://circleci.com/gh/sameersbn/docker-mongodb.svg?style=svg)](https://circleci.com/gh/sameersbn/docker-mongodb)

# Table of Contents
- [Introduction](#introduction)
- [Contributing](#contributing)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Data Store](#data-store)
- [Shell Access](#shell-access)
- [Upgrading](#upgrading)

# Introduction
Dockerfile to build a MongoDb container image which can be linked to other containers.

# Contributing

If you find this image useful here's how you can help:

- Send a Pull Request with your awesome new features and bug fixes
- Help new users with [Issues](https://github.com/sameersbn/docker-mongodb/issues) they may encounter
- Support the development of this image with a [donation](http://www.damagehead.com/donate/)

# Installation

Pull the latest version of the image from the docker index. This is the recommended method of installation as it is easier to update image in the future. These builds are performed by the **Docker Trusted Build** service.

```
docker pull sameersbn/mongodb:latest
```

Alternately you can build the image yourself.

```
git clone https://github.com/sameersbn/docker-mongodb.git
cd docker-mongodb
docker build -t="$USER/mongodb" .
```

# Quick Start
Run the mongodb image

```
docker run --name mongodb -d sameersbn/mongodb:latest
```

To test if the mongodb server is configured properly, try connecting to the server.

```
mongo $(docker inspect --format {{.NetworkSettings.IPAddress}} mongodb)
```

# Data Store
You should mount a volume at /var/lib/mongodb.

```
mkdir -p /opt/mongodb
docker run -name mongodb -d \
  -v /opt/mongodb:/var/lib/mongodb sameersbn/mongodb:latest
```

This will make sure that the data stored in the database is not lost when the image is stopped and started again.

# Shell Access

For debugging and maintenance purposes you may want access the containers shell. If you are using docker version `1.3.0` or higher you can access a running containers shell using `docker exec` command.

```bash
docker exec -it mongodb bash
```

If you are using an older version of docker, you can use the [nsenter](http://man7.org/linux/man-pages/man1/nsenter.1.html) linux tool (part of the util-linux package) to access the container shell.

Some linux distros (e.g. ubuntu) use older versions of the util-linux which do not include the `nsenter` tool. To get around this @jpetazzo has created a nice docker image that allows you to install the `nsenter` utility and a helper script named `docker-enter` on these distros.

To install `nsenter` execute the following command on your host,

```bash
docker run --rm -v /usr/local/bin:/target jpetazzo/nsenter
```

Now you can access the container shell using the command

```bash
sudo docker-enter mongodb
```

For more information refer https://github.com/jpetazzo/nsenter

# Upgrading

To upgrade to newer releases, simply follow this 3 step upgrade procedure.

- **Step 1**: Stop the currently running image

```
docker stop mongodb
```

- **Step 2**: Update the docker image.

```
docker pull sameersbn/mongodb:latest
```

- **Step 3**: Start the image

```
docker run -name mongodb -d [OPTIONS] sameersbn/mongodb:latest
```
