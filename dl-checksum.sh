#!/usr/bin/env sh
set -e
DIR=~/Downloads
MIRROR=https://github.com/starship/starship/releases/download

dl()
{
    local ver=$1
    local arch=$2
    local os=$3
    local archive_type=${4:-tar.gz}
    local platform="${arch}-${os}"

    local url=$MIRROR/$ver/starship-${platform}.${archive_type}.sha256

    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform $(curl -sSLf $url)
}

dl_ver() {
    local ver=$1
    printf "  %s:\n" $ver
    dl $ver x86_64 apple-darwin
    dl $ver x86_64 pc-windows-msvc zip
    dl $ver x86_64 unknown-linux-gnu
    dl $ver x86_64 unknown-linux-musl
    dl $ver aarch64 apple-darwin
    dl $ver aarch64 unknown-linux-musl
    dl $ver aarch64 pc-windows-msvc zip
    dl $ver arm unknown-linux-musleabihf
}

dl_ver ${1:-v1.15.0}
