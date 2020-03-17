#!/bin/bash

COMPONENT=$(python -c "print('${TRAVIS_TAG}'.split('-v')[0])")
echo "Component is ${COMPONENT}"
DOCKERFILE_PATH=installer/dockerfile/${COMPONENT}/Dockerfile.build
echo "Dockerfile path is ${DOCKERFILE_PATH}"
IMAGE_TAG=$(python -c "print('v' + '${TRAVIS_TAG}'.split('-v')[1])")
IMAGE_NAME=${DOCKER_IMAGE_ORG}/volcano-${COMPONENT}:${IMAGE_TAG}
echo "Image name is ${IMAGE_NAME}"
echo "$DOCKER_HUB_ACCESS_TOKEN" | docker login -u "$DOCKER_HUB_USERNAME" --password-stdin && \
  docker build -t $IMAGE_NAME -f $DOCKERFILE_PATH . && \
  docker push $IMAGE_NAME
