mkdir tmp
pushd tmp &&
curl -L -o qemu-arm-static.tar.gz https://github.com/multiarch/qemu-user-static/releases/download/v2.6.0/qemu-arm-static.tar.gz &&
tar xzf qemu-arm-static.tar.gz &&
popd
# build image
docker build -t yovio/armhf-node-red:build .
# test image
docker run yovio/armhf-node-red:build uname -a
# push image
if [ "$TRAVIS_BRANCH" == "master" ]; then
  docker login -u="$DOCKER_USER" -p="$DOCKER_PASS"
  TAG=$(grep "FROM " Dockerfile | sed 's/.*://')
  docker tag yovio/armhf-node-red:build yovio/armhf-node:$TAG
  docker tag yovio/armhf-node-red:build yovio/armhf-node:latest
  docker push yovio/armhf-node-red:$TAG
  docker push yovio/armhf-node-red:latest
fi
rm -Rf tmp
