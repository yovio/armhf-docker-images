mkdir tmp
pushd tmp &&
curl -L -o qemu-arm-static.tar.gz https://github.com/multiarch/qemu-user-static/releases/download/v2.6.0/qemu-arm-static.tar.gz &&
tar xzf qemu-arm-static.tar.gz &&
popd
# build image
docker build -t yovio/armhf-node:build .
# test image
docker run yovio/armhf-node:build uname -a
# push image
if [ "$TRAVIS_BRANCH" == "master" ]; then
  docker login -u="$DOCKER_USER" -p="$DOCKER_PASS"
  TAG=$(grep "FROM " Dockerfile | sed 's/.*://')
  docker tag yovio/armhf-node:build yovio/armhf-node:6.9.5
  docker tag yovio/armhf-node:build yovio/armhf-node:latest
  docker push yovio/armhf-node:6.9.5
  docker push yovio/armhf-node:latest
fi
rm -Rf tmp
