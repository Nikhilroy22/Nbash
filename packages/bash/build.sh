TERMUX_PKG_NAME="bash"
TERMUX_PKG_VERSION=5.3
TERMUX_PKG_SRCURL=https://ftp.gnu.org/gnu/bash/bash-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=62dd49c44c399ed1b3f7f731e87a782334d834f08e098a35f2c87547d5dbb269
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--without-bash-malloc"

termux_step_post_make_install() {
  echo "[✔] Post-install step (if needed)"
}