# imagemagick-heic-static
Static ImageMagick binaries with HEIC support. Only supports for HEIC and PNG is included for converting HEIC images to PNG.

## To build a new release using docker for CentOS 7

First update the build.sh script for new versions.

Download the build.sh script to your system:

```
$ curl -L https://raw.githubusercontent.com/Ksyos/imagemagick-heic-static/master/build.sh > build.sh
```

Then, on host system, delete your previous buildbox when you have one:

```
$ docker rm mybuildbox
```

Create a new one:

```
$ docker run --name='mybuildbox' -it rsippl/centos-dev
```

Then on host system from another terminal, copy the build script to the container:

```
$ docker cp build.sh mybuildbox:/root
```

From docker container:

```
$ chmod +x build.sh && ./build.sh
```

Wait for the compilation to finish. Then, from host, copy the resulting release file:

```
$ docker cp mybuildbox:/root/imagemagick-workspace/imagemagick-heic-static-centos7.tgz .
```

Now go on and create new release in GitHub!
