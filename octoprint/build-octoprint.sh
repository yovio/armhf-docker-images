APP_VER=1.3.4

mkdir tmp
pushd tmp &&
curl -L -o qemu-arm-static.tar.gz https://github.com/multiarch/qemu-user-static/releases/download/v2.6.0/qemu-arm-static.tar.gz &&
tar xzf qemu-arm-static.tar.gz &&
popd
# build image
docker build -t yovio/armhf-octoprint:build --build-arg OCTOPRINT_VERSION=$APP_VER .
# test image
docker run yovio/armhf-octoprint:build uname -a
# push image
if [ "$TRAVIS_BRANCH" == "master" ]; then
  docker login -u="$DOCKER_USER" -p="$DOCKER_PASS"
  TAG=$(grep "FROM " Dockerfile | sed 's/.*://')
  docker tag yovio/armhf-octoprint:build yovio/armhf-octoprint:$APP_VER
  docker tag yovio/armhf-octoprint:build yovio/armhf-octoprint:latest
  docker push yovio/armhf-octoprint:$APP_VER
  docker push yovio/armhf-octoprint:latest
fi
rm -Rf tmp
