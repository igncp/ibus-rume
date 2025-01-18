#!/usr/bin/env bash

set -e

docker build \
  -t ibus_rume \
  --progress plain \
  .
