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

#### Sample Configuration Template
For more up-to-date configuration documentation and snippets, refer to the [oxidized project cookbook](https://github.com/ytti/oxidized#cookbook).

This is a sample configuration that I have used, obviously some information has been redacted.

```yaml
---
username: <TACACS_USER>
password: <TACACS_PASS>
interval: 3600
use_syslog: true
debug: true
threads: 30
timeout: 20
retries: 3
prompt: !ruby/regexp /^([\w.@-]+[#>]\s?)$/
rest: 0.0.0.0:8888
vars: {}
groups: {}
pid: "/var/run/oxidized/pid"
input:
  default: ssh, telnet
  debug: false
  ssh:
    secure: false
output:
  default: git
  git:
      user: <GIT_COMMIT_USER>
      email: <GIT_COMMIT_EMAIL>
      repo: "/var/lib/oxidized/oxidized.git"
source:
  default: csv
  csv:
    file: "/etc/oxidized/router.db"
    delimiter: !ruby/regexp /:/
    map:
      name: 0
      model: 1
model_map:
  cisco: ios
  juniper: junos
  foundry: ironware
  extreme: xos
hooks:
  push_to_remote:
    type: githubrepo
    events: [post_store]
    remote_repo: <GIT_REMOTE_URL>
    publickey: "/etc/oxidized/publickey"
    privatekey: "/etc/oxidized/privatekey"
  slack:
    type: slackdiff
    events: [post_store]
    token: <SLACK_BOT_TOKEN>
    channel: "#<SLACK_CHANNEL>"
```

It is advised you also cosider [removing secrets](https://github.com/ytti/oxidized#removing-secrets) when storing configuration.
