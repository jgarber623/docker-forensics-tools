# docker-forensics-tools

**A suite of [Docker](https://www.docker.com) images containing useful forensics tools.**

[![Build](https://img.shields.io/travis/jgarber623/docker-forensics-tools.svg?style=for-the-badge)](https://travis-ci.org/jgarber623/docker-forensics-tools)

## Getting Started

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
docker build -t forensics-tools:base ./base
docker build -t forensics-tools:bulk_extractor ./bulk_extractor
```

These two commands will create tagged `forensics-tools` images. Each image will contain the tools specified in the associated `Dockerfile`s.

## Running

Run the generated images using the following commands:

```sh
docker run --rm -it forensics-tools:base
docker run --rm -it forensics-tools:bulk_extractor
```

This command will run an interactive session (`-i`), allocate a pseudo-TTY (`-t`), and remove the container when exiting (`--rm`).

The full list of installed packages can be viewed by running `apt list --installed` from the launched container's shell.

## License

docker-forensics-tools is freely available under the [MIT License](https://opensource.org/licenses/MIT).
