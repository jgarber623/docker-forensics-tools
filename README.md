# docker-forensics-tools

**A [Docker](https://www.docker.com) image containing useful forensics tools.**

[![Build](https://img.shields.io/travis/jgarber623/docker-forensics-tools.svg?style=for-the-badge)](https://travis-ci.org/jgarber623/docker-forensics-tools)

This image includes tools from the [forensics-all](https://packages.debian.org/unstable/forensics-all) and [forensics-extra](https://packages.debian.org/unstable/forensics-extra) Debian metapackages, [Simson Garfinkel's bulk_extractor](https://github.com/simsong/bulk_extractor), and [Yahoo's open_nsfw Caffe models](https://github.com/yahoo/open_nsfw).

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

Run the generated image using the following command:

```sh
docker run --rm -it forensics-tools
```

This command will run an interactive session (`-i`), allocate a pseudo-TTY (`-t`), and remove the container when exiting (`--rm`).

The full list of installed packages can be view by running `apt list --installed` from the launched container's shell.

## License

docker-forensics-tools is freely available under the [MIT License](http://opensource.org/licenses/MIT).
