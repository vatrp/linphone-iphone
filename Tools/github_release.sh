#!/bin/bash
set -x

curl -sL https://github.com/aktau/github-release/releases/download/v0.5.3/darwin-amd64-github-release.tar.bz2 | bunzip2 -cd | tar xf - --strip=3 -C /tmp/

tag=build-$(date +%Y%m%d%H%M%S).$(git rev-parse --short HEAD)
#tag=$(grep -1 CFBundleVersion linphone-Info.plist  |grep string | sed -e 's/^.*<string>//' -e 's/<\/string>.*$//').$TRAVIS_BUILD_NUMBER

/tmp/github-release release \
    --user vatrp \
    --repo linphone-iphone \
    --tag $tag \
    --name "CI Automated $tag" \
    --description "This is an automatically generated tag that will eventually be expired" \
    --pre-release

tarball=/tmp/linphone-iphone-build.tar.bz2
tar cjf $tarball .

/tmp/github-release upload \
    --user vatrp \
    --repo linphone-iphone \
    --tag $tag \
    --name $(basename $tarball) \
    --file $tarball

