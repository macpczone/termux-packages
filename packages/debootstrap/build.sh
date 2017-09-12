TERMUX_PKG_HOMEPAGE=https://wiki.debian.org/Debootstrap
TERMUX_PKG_DESCRIPTION="Bootstrap a basic Debian system"
TERMUX_PKG_VERSION=1.0.90
TERMUX_PKG_SRCURL=http://mirror.sucs.swan.ac.uk/pub/linux/debian/pool/main/d/debootstrap/debootstrap_${TERMUX_PKG_VERSION}~bpo9+1.tar.gz
TERMUX_PKG_SHA256=a5b86fff7b73d6640168ec77b1b3a4a6d0b8abf6852e4dae077911c0af1dc1ab
TERMUX_PKG_BUILD_IN_SRC=yes
TERMUX_PKG_DEPENDS="wget, proot"
TERMUX_PKG_MAINTAINER="Pierre Rudloff @Rudloff"

termux_step_post_make_install() {
    mkdir -p ${TERMUX_PREFIX}/share/man/man8/
    install ${TERMUX_PKG_SRCDIR}/debootstrap.8 ${TERMUX_PREFIX}/share/man/man8/
}
