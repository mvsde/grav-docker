# Grav CMS Docker

## Build latest

```bash
docker build --tag grav .
```

## Build specific version

```bash
VERSION=1.7.10 docker build --tag grav:$VERSION --build-arg GRAV_VERSION=$VERSION .
```

## Docker compose

```yaml
services:
  grav:
    image: grav:latest
    build:
      context: github.com/mvsde/grav-docker
      args:
        GRAV_VERSION: 1.7.10
    container_name: project-name
    ports:
      - 8000:80
    volumes:
      - ./path/to/theme:/var/www/html/user/themes/project-name
      - ./tmp/volumes/user:/var/www/html/user
```
