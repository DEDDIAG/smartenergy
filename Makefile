NAMESPACE=lv/$(shell basename `pwd`)
DOCKER_REGISTRY=inf-docker.fh-rosenheim.de
.RECIPEPREFIX != ps

PLATFORM=$(shell uname -m)
VERSION=${PLATFORM}-$(shell git rev-parse --short HEAD)
DOCKER_FILE=Dockerfile.${PLATFORM}

default: build

build:
    docker build --tag ${DOCKER_REGISTRY}/${NAMESPACE}:${VERSION} -f ${DOCKER_FILE} .

force-build:
    docker build --no-cache --tag ${DOCKER_REGISTRY}/${NAMESPACE}:${VERSION} -f ${DOCKER_FILE} .

push:
    docker push ${DOCKER_REGISTRY}/${NAMESPACE}:${VERSION}

run:
    docker run --name ${NAMESPACE} -ti ${DOCKER_REGISTRY}/${NAMESPACE}:${VERSION}

clean:
    docker rm ${NAMESPACE}
.PHONY: clean push force-build
