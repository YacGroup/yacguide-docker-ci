## [YacGuide] Docker Build Environment

[![CI](https://github.com/YacGroup/yacguide-docker-ci/actions/workflows/ci.yaml/badge.svg)](https://github.com/YacGroup/yacguide-docker-ci/actions/workflows/ci.yaml)

This is the Docker image for building the [YacGuide] Android app.

The image can be found at the [Docker hub].

For manually building the image, run the following command inside the
root of your local Git repository:

``` shell
docker build -f Dockerfile -t yacgroup/yacguide-build .
```


[YacGuide]: https://yacgroup.github.io/yacguide/
[Docker hub]: https://hub.docker.com/repository/docker/yacgroup/yacguide-build
