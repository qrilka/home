(package-initialize)

;; UI
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq column-number-mode t)
(set-frame-font "LiberationMono-10")
(use-package material-theme
  :ensure t
  :init
  (load-theme 'material t))
(blink-cursor-mode 0)
;; inital view
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)

;; auto revert mode
(global-auto-revert-mode 1)

;; recentf
(use-package recentf
  :config
  (recentf-mode 1)
  (setq recentf-max-menu-items 50)
  (setq recentf-max-saved-items 50)
  :init
  (global-set-key "\C-x\C-r" 'recentf-open-files))

;; we don't need no tabs
(setq-default indent-tabs-mode nil)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(use-package selectrum
  :ensure t
  :init (selectrum-mode +1))

(use-package prescient
  :config
  (prescient-persist-mode +1))

(use-package selectrum-prescient
  :init
  (selectrum-prescient-mode +1)
  :after selectrum)

(use-package flycheck
  :config
  (flycheck-pos-tip-mode)
  :hook (prog-mode . flycheck-mode))

(use-package all-the-icons
  :ensure t)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom
  (doom-modeline-icon (display-graphic-p)))

(use-package dante
  :ensure t
  :after haskell-mode
  :commands 'dante-mode
  :init
  (add-hook 'haskell-mode-hook 'flycheck-mode)
  (add-hook 'haskell-mode-hook 'dante-mode)
  )

;(use-package ormolu
;  :after dante
;  :hook haskell-mode
;  :bind
;  (:map haskell-mode-map
;        ("<M-return>" . ormolu-format-region)))

(use-package magit
  :custom
  (magit-log-margin '(t "%Y-%m-%d %H:%M " magit-log-margin-width t 18))
  :bind
  (("C-x g" . magit-status )))

(use-package forge
  :after magit)

(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package yaml-mode
  :mode "\\.ya?ml\\'")

(use-package purescript-mode
  :mode "\\.purs\\'")

(use-package typescript-mode
  :mode "\\.tsx\\'")

(use-package cargo
  :hook (rust-mode . cargo-minor-mode))

(use-package rust-mode
  :hook (rust-mode . lsp)
  :mode "\\.rs\\'")

(use-package flycheck-rust
  :config (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(use-package lsp-mode
  :ensure t
  :init (setq lsp-keymap-prefix "C-l")
  :commands lsp)

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package terraform-mode
  :mode "\\.tf\\'")


(use-package neotree
  :ensure t
  :init
  (global-set-key [f8] 'neotree-toggle))


(defun disable-electric-indent ()
  "Disable electric indenting."
  (electric-indent-local-mode -1))

(use-package org
  :bind
  (:map global-map
        ("C-c l" . org-store-link)
        ("C-c c" . org-capture)
        ("C-c a" . org-agenda))
  :hook (org-mode . disable-electric-indent);(electric-indent-local-mode -1));((add-hook! 'org-mode-hook (electric-indent-local-mode -1))
  :init
  (setq org-agenda-start-on-weekday nil)
  (setq org-default-notes-file "~/ws/org/notes.org")
  (setq org-agenda-files (list "~/ws/org/work.org"
                               "~/ws/org/open-source.org"
                               "~/ws/org/misc-notes.org"
                               "~/ws/org/books.org"
                               "~/ws/org/learning.org"
                               "~/ws/org/home.org"))
  (setq org-todo-keywords
        '((sequence "TODO(t)" "IN-PROCESS(p)" "|" "DONE(d)")
          (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)")))
  (setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("IN-PROCESS" :foreground "deep sky blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold))))
  (setq org-capture-templates
      (quote (("t" "todo" entry (file "~/ws/org/todo.org")
               "* TODO %?\n%U\n%a\n")
              ("n" "note" entry (file "~/ws/org/notes.org")
               "* %? :NOTE:\n%U\n%a\n")
              ("j" "Journal" entry (file+datetree "~/ws/org/diary.org")
               "* %?\n%U\n"))))
  ; Targets include this file and any file contributing to the agenda - up to 9 levels deep
  (setq org-refile-targets (quote ((nil :maxlevel . 9)
                                   (org-agenda-files :maxlevel . 9))))
  (setq org-refile-use-outline-path 'file)
  ;; makes org-refile outline working with helm/ivy
  (setq org-outline-path-complete-in-steps nil)
  (setq org-refile-allow-creating-parent-nodes 'confirm)
  (setq org-log-into-drawer t))

(use-package rg
  :init
  (rg-enable-default-bindings))

(use-package diff-hl
  :hook ((prog-mode . diff-hl-mode)
         (magit-post-refresh . diff-hl-magit-post-refresh)))

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("s-p" . projectile-command-map)
              ("C-c p" . projectile-command-map)))

(add-to-list 'safe-local-variable-values
             '(dante-methods stack))
(put 'dante-target 'safe-local-variable #'stringp)

(use-package direnv
  :config
  (direnv-mode))

(provide 'init)
;;; init.el ends here
