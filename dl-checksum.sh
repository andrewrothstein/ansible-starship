#!/usr/bin/env sh
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
    printf "    %s: sha256:%s\n" $platform $(curl -sSL $url)
}

dl_ver() {
    local ver=$1
    printf "  %s:\n" $ver
    dl $ver x86_64 apple-darwin
    dl $ver x86_64 pc-windows-msvc zip
    dl $ver x86_64 unknown-linux-gnu
    dl $ver x86_64 unknown-linux-musl
}

dl_ver ${1:-v0.44.0}
