#!/bin/bash

VERSION=1.0.0-M11
CACHE_VERSION=v1

SBTPACK_LAUNCHER="$(dirname "$0")/../cli/target/pack/bin/coursier"

if [ ! -f "$SBTPACK_LAUNCHER" ]; then
  sbt cli/pack
fi

"$SBTPACK_LAUNCHER" bootstrap \
  io.get-coursier:coursier-cli-java-6_2.11:$VERSION \
  --classifier standalone \
  --intransitive \
  -J "-noverify" \
  --no-default \
  -r central \
  -r sonatype:releases \
  -d "\${user.home}/.coursier/bootstrap/$VERSION" \
  -f -o coursier \
  -M coursier.cli.Coursier \
  -D coursier.cache="\${user.home}/.coursier/cache/$CACHE_VERSION" \
  "$@"
