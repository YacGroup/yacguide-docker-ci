## [YacGuide] Docker Build Environment

This is the Docker image for building the [YacGuide] Android app.

The image can be found at the [Docker hub].

Since the free subscription of docker no longer supports automatic
builds based on pushes, you need to do this job locally. For this, run
the following command inside root of your local Git repository:

``` shell
docker build -f Dockerfile -t yacgroup/yacguide-build .
```

After a successful build and test, tag the image based on the today's
timestamp `YYYYMMDD`.

``` shell
docker tag yacgroup/yacguide-build:latest yacgroup/yacguide-build:YYYYMMDD
```

Finally, push both images to the [Docker hub].

``` shell
docker push yacgroup/yacguide-build:latest
docker push yacgroup/yacguide-build:YYYYMMDD
```


[YacGuide]: https://yacgroup.github.io/yacguide/
[Docker hub]: https://hub.docker.com/repository/docker/yacgroup/yacguide-build
