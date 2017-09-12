TERMUX_PKG_HOMEPAGE=https://php.net
TERMUX_PKG_DESCRIPTION="Server-side, HTML-embedded scripting language"
TERMUX_PKG_VERSION=7.1.8
TERMUX_PKG_SHA256=8943858738604acb33ecedb865d6c4051eeffe4e2d06f3a3c8f794daccaa2aab
TERMUX_PKG_SRCURL=http://www.php.net/distributions/php-${TERMUX_PKG_VERSION}.tar.xz
# Build native php for phar to build (see pear-Makefile.frag.patch):
TERMUX_PKG_HOSTBUILD=true
# Build the native php without xml support as we only need phar:
TERMUX_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="--disable-libxml --disable-dom --disable-simplexml --disable-xml --disable-xmlreader --disable-xmlwriter --without-pear"
TERMUX_PKG_DEPENDS="libandroid-glob, libxml2, liblzma, openssl, pcre, libbz2, libcrypt, libcurl, libgd, readline, freetype"
TERMUX_PKG_RM_AFTER_INSTALL="php/php/fpm"

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_res_nsearch=no
--enable-bcmath
--enable-calendar
--enable-exif
--enable-gd-native-ttf=$TERMUX_PREFIX
--enable-mbstring
--enable-opcache
--enable-pcntl
--enable-sockets
--enable-zip
--mandir=$TERMUX_PREFIX/share/man
--with-bz2=$TERMUX_PREFIX
--with-curl=$TERMUX_PREFIX
--with-freetype-dir=$TERMUX_PREFIX
--with-gd=$TERMUX_PREFIX
--with-iconv=$TERMUX_PREFIX
--with-libxml-dir=$TERMUX_PREFIX
--with-openssl=$TERMUX_PREFIX
--with-pcre-regex=$TERMUX_PREFIX
--with-png-dir=$TERMUX_PREFIX
--with-readline=$TERMUX_PREFIX
--with-zlib
--with-pgsql=shared,$TERMUX_PREFIX
--with-pdo-pgsql=shared,$TERMUX_PREFIX
--with-apxs2=$TERMUX_PREFIX/bin/apxs
--enable-fpm
--sbindir=$TERMUX_PREFIX/bin
"

termux_step_pre_configure () {
	LDFLAGS+=" -landroid-glob -llog"

	export PATH=$PATH:$TERMUX_PKG_HOSTBUILD_DIR/sapi/cli/
	export NATIVE_PHP_EXECUTABLE=$TERMUX_PKG_HOSTBUILD_DIR/sapi/cli/php

	# Run autoconf since we have patched config.m4 files.
	autoconf

	export EXTENSION_DIR=$TERMUX_PREFIX/lib/php
}

termux_step_post_configure () {
	# Avoid src/ext/gd/gd.c trying to include <X11/xpm.h>:
	sed -i 's/#define HAVE_GD_XPM 1//' $TERMUX_PKG_BUILDDIR/main/php_config.h
	# Avoid src/ext/standard/dns.c trying to use struct __res_state:
	sed -i 's/#define HAVE_RES_NSEARCH 1//' $TERMUX_PKG_BUILDDIR/main/php_config.h
}

termux_step_post_make_install () {
	mkdir -p $TERMUX_PREFIX/etc/php-fpm.d
	cp sapi/fpm/php-fpm.conf $TERMUX_PREFIX/etc/
	cp sapi/fpm/www.conf $TERMUX_PREFIX/etc/php-fpm.d/

	sed -i 's/SED=.*/SED=sed/' $TERMUX_PREFIX/bin/phpize
}
