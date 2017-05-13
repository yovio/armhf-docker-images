mkdir tmp
pushd tmp &&
curl -L -o qemu-arm-static.tar.gz https://github.com/multiarch/qemu-user-static/releases/download/v2.6.0/qemu-arm-static.tar.gz &&
tar xzf qemu-arm-static.tar.gz &&
popd
# build image
docker build -t yovio/armhf-alpine:build --build-arg ALPINE_TAG=$ALPINE_TAG .
# test image
docker run yovio/armhf-alpine:build uname -a
# push image
if [ "$TRAVIS_BRANCH" == "master" ]; then
  docker login -u="$DOCKER_USER" -p="$DOCKER_PASS"
  TAG=$(grep "FROM " Dockerfile | sed 's/.*://')
  docker tag yovio/armhf-alpine:build yovio/armhf-alpine:$ALPINE_TAG
  docker tag yovio/armhf-alpine:build yovio/armhf-alpine:latest
  docker push yovio/armhf-alpine:$ALPINE_TAG
  docker push yovio/armhf-alpine:latest
fi
rm -Rf tmp
