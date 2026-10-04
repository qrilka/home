emacs-check:
    #!/usr/bin/env bash
    set -euo pipefail
    tmp_home=$(mktemp -d)
    trap 'rm -rf "$tmp_home"' EXIT
    HOME="$tmp_home" emacs --batch -Q \
      -l emacs/init.el \
      -l emacs/check-init.el
