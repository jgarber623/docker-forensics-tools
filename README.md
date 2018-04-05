# docker-forensics-tools

A [Docker](https://www.docker.com) image built with useful forensics-related tools. This image includes tools from the [forensics-all](https://packages.debian.org/unstable/forensics-all) and [forensics-extra](https://packages.debian.org/unstable/forensics-extra) Debian metapackages.

## Installation

If you're using macOS, the easiest way to install [Docker for Mac](https://www.docker.com/docker-mac) is with [Homebrew](https://brew.sh):

```sh
brew cask install docker
```

With Docker installed and running, clone this repository:

```sh
git clone https://github.com/jgarber623/docker-forensics-tools
```

## Building

From the root of this project, run:

```sh
docker build -t forensics-tools .
```

This command will create a tagged image with the tools described in [`Dockerfile`](https://github.com/jgarber623/docker-forensics-tools/blob/master/Dockerfile).

## Running

To launch a container to a [Bash](https://www.gnu.org/software/bash/) prompt, run the following command:

```sh
docker run --rm -it forensics-tools bash
```

This command will run an interactive session (`-i`), allocate a pseudo-TTY (`-t`), and remove the container when exiting (`--rm`).

The full list of installed packages can be view by running `apt list --installed` from the launched container's shell.

## License

docker-forensics-tools is freely available under the [MIT License](http://opensource.org/licenses/MIT).