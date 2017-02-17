# Oxidized: Alpine Linux based Docker image

This is a docker image for the amazing [oxidized](https://github.com/ytti/oxidized) tool. For how to configure oxidized see the oxidized [README.md](https://github.com/ytti/oxidized/blob/master/README.md) file.

This image exists as a smaller footprint version of the [official image](https://hub.docker.com/u/oxidized/).

```sh
$ docker images | grep oxidized
alectolytic/oxidized                         latest              47d02d05a190        3 minutes ago       105.7 MB
docker.io/oxidized/oxidized                  latest              322273566e60        12 hours ago        611.3 MB
```

#### Usage Example
```sh
$ docker run --rm -it -v </path/to/config/dir>:/etc/oxidized -p 8888:8888 alectolytic/oxidized --help
Usage: oxidized [options]
    -d, --debug          turn on debugging
        --daemonize      Daemonize/fork the process
    -v, --version        show version
    -h, --help           Display this help message.
```

Note that, for obvious reasons using `--daemonize` will not work as advertised.
