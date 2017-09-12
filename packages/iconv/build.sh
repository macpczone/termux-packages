TERMUX_PKG_HOMEPAGE=https://www.gnu.org/software/libiconv/
TERMUX_PKG_DESCRIPTION="Utility converting between different character encodings"
TERMUX_PKG_VERSION=1.15
TERMUX_PKG_SRCURL=https://mirrors.kernel.org/gnu/libiconv/libiconv-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=ccf536620a45458d26ba83887a983b96827001e92a13847b45e4925cc8913178
# Only install the binary, not the library since we use libandroid-support for iconv functions:
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--enable-static --disable-shared"

termux_step_make_install () {
	mkdir -p $TERMUX_PREFIX/share/man/man1
	make -C lib install # this installs libiconv.{a,la} which the below install task needs:
	make -C src install
        rm $TERMUX_PREFIX/lib/libiconv.{a,la}
        # .. and the man page:
        cp $TERMUX_PKG_SRCDIR/man/iconv.1 $TERMUX_PREFIX/share/man/man1/
}
