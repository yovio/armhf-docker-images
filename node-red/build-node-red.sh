APP_VER=0.16.2

mkdir tmp
pushd tmp &&
curl -L -o qemu-arm-static.tar.gz https://github.com/multiarch/qemu-user-static/releases/download/v2.6.0/qemu-arm-static.tar.gz &&
tar xzf qemu-arm-static.tar.gz &&
popd
# build image
docker build -t yovio/armhf-node-red:alpine-build -f Dockerfile.alpine .
docker build -t yovio/armhf-node-red:build -f Dockerfile .
# test image
docker run yovio/armhf-node-red:alpine-build uname -a
docker run yovio/armhf-node-red:build uname -a
# push image
if [ "$TRAVIS_BRANCH" == "master" ]; then
  docker login -u="$DOCKER_USER" -p="$DOCKER_PASS"
  
  docker tag yovio/armhf-node-red:build yovio/armhf-node-red:$APP_VER
  docker tag yovio/armhf-node-red:build yovio/armhf-node-red:latest
  
  docker tag yovio/armhf-node-red:alpine-build yovio/armhf-node-red:alpine-$APP_VER
  docker tag yovio/armhf-node-red:alpine-build yovio/armhf-node-red:alpine
  
  docker push yovio/armhf-node-red:$APP_VER
  docker push yovio/armhf-node-red:latest
  
  docker push yovio/armhf-node-red:alpine-$APP_VER
  docker push yovio/armhf-node-red:alpine
fi
rm -Rf tmp
