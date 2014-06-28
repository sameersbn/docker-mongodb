# Table of Contents
- [Introduction](#introduction)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
    - [Data Store](#data-store)
- [Upgrading](#upgrading)

# Introduction
Dockerfile to build a MongoDb container image which can be linked to other containers.

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
docker run -name mongodb -d sameersbn/mongodb:latest
MONGODB_IP=$(docker inspect mongodb | grep IPAddres | awk -F'"' '{print $4}')
```

To test if the mongodb server is configured properly, try connecting to the server.

```
mongo ${MONGODB_IP}
```

# Configuration

## Data Store
You should mount a volume at /var/lib/mongodb.

```
mkdir -p /opt/mongodb
docker run -name mongodb -d \
  -v /opt/mongodb:/var/lib/mongodb sameersbn/mongodb:latest
```

This will make sure that the data stored in the database is not lost when the image is stopped and started again.

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
