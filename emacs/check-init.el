;; Focused smoke checks for init.el; add checks here as new regressions need
;; coverage. This guards Rust LSP startup ordering for directory-local features.
(unless (and (memq 'lsp-deferred rust-ts-mode-hook)
             (not (memq 'lsp rust-ts-mode-hook)))
  (error "Rust LSP must start through lsp-deferred"))

(unless (and (autoloadp (symbol-function 'lsp))
             (autoloadp (symbol-function 'lsp-deferred)))
  (error "Both LSP entry points must be autoloaded"))

(princ "Emacs init checks passed.\n")
