# using a snapshot tarball because blogc-0.13.0 is not ready for release yet
# (documentation updates pending), but it is already useful and stable enough

TERMUX_PKG_HOMEPAGE=https://blogc.rgm.io/
TERMUX_PKG_DESCRIPTION="A blog compiler"
TERMUX_PKG_VERSION=0.12.0.123.acf1
TERMUX_PKG_REVISION=1
TERMUX_PKG_MAINTAINER="Rafael Martins @rafaelmartins"
TERMUX_PKG_SRCURL="https://github.com/blogc/blogc/releases/download/v0.12.0/blogc-0.12.0.tar.xz"
TERMUX_PKG_SHA256=85453c0184396f217ac95ae8ba70f0693b16f57321f82a09b7ff46d3a1d257ac
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--disable-git-receiver --enable-make --enable-runserver --disable-tests --disable-valgrind"
