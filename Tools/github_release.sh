#!/bin/bash
set -x

curl -sL https://github.com/aktau/github-release/releases/download/v0.5.3/darwin-amd64-github-release.tar.bz2 | bunzip2 -cd | tar xf - --strip=3 -C /tmp/

tag=build-$(date +%Y%m%d%H%M%S).$(git rev-parse --short HEAD)

/tmp/github-release release \
    --user vatrp \
    --repo linphone-iphone \
    --tag $tag \
    --name "CI Automated $tag" \
    --description "This is an automatically generated tag that will eventually be expired" \
    --pre-release

tarball=linphone-build.tar.bz2
tar cjf $tarball . --exclude $tarball

/tmp/github-release upload \
    --user vatrp \
    --repo linphone-iphone \
    --tag $tag \
    --name $(basename $tarball) \
    --file $tarball

