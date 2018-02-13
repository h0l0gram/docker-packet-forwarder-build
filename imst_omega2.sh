#!/bin/bash

git clone https://github.com/WereCatf/source lede
./scripts/feeds update -a
./scripts/feeds install -a
make defconfig

GIT_SOURCE="https://github.com/TheThingsNetwork/packet_forwarder.git"
GIT_BRANCH=${1:-"-b master"}
GIT_TARGET="/root/go/src/github.com/TheThingsNetwork/packet_forwarder"

printf "\e[0;32m\nGit Clone packet_forwarder\n"
git clone $GIT_SOURCE $GIT_BRANCH $GIT_TARGET

cd $GIT_TARGET
printf "\e[1;33m\nBuilding IMST Omega2\n\n"
printf "\e[0;32m\nmake dev-deps\n***************\n"
make dev-deps

printf "\e[0;32m\nSet IMST Omega2 ENVIRONMENT\n***************\n"
#export PLATFORM=imst_rpi
export GOOS=linux
export GOARCH=mipsle
#export CC=arm-linux-gnueabihf-gcc
export CGO_ENABLED=1
export RELEASE_DIR="/root/release"

printf "\e[0;32m\nmake deps\n***************\n"
make deps

printf "\e[0;32mm\nake build\n***************\n"
make build RELEASE_DIR=/root/release

