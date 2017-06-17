MQT_VER=1.4.12-r0

mkdir tmp
pushd tmp &&
curl -L -o qemu-arm-static.tar.gz https://github.com/multiarch/qemu-user-static/releases/download/v2.6.0/qemu-arm-static.tar.gz &&
tar xzf qemu-arm-static.tar.gz &&
popd
# build image
docker build -t yovio/armhf-mosquitto:build --build-arg MOSQUITTO_VER=$MQT_VER .
# test image
docker run yovio/armhf-mosquitto:build uname -a
# push image
if [ "$TRAVIS_BRANCH" == "master" ]; then
  docker login -u="$DOCKER_USER" -p="$DOCKER_PASS"
  TAG=$(grep "FROM " Dockerfile | sed 's/.*://')
  docker tag yovio/armhf-mosquitto:build yovio/armhf-mosquitto:alpine-$MQT_VER
  docker tag yovio/armhf-mosquitto:build yovio/armhf-mosquitto:alpine
  docker push yovio/armhf-mosquitto:alpine-$MQT_VER
  docker push yovio/armhf-mosquitto:alpine
fi
rm -Rf tmp
