(package-initialize)

;; UI
(tool-bar-mode -1)
(menu-bar-mode -1)
(set-default-font "LiberationMono-10")
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

(use-package ivy
  :diminish ivy-mode
  :config
  (ivy-mode 1))

;;smex
(global-set-key (kbd "M-x") 'smex)

(use-package powerline
  :config
  (powerline-center-theme))

(use-package hindent
  :ensure t
  :config
  (setq hindent-style "johan-tibell"))
(add-hook 'haskell-mode-hook #'hindent-mode)

(use-package intero)

(use-package magit
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

(use-package rust-mode
  :mode "\\.rs\\'")

(use-package terraform-mode
  :mode "\\.tf\\'")

(use-package treemacs
  :ensure t
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-magit
  :after treemacs magit
  :ensure t)

(use-package org
  :bind
  (:map global-map
        ("C-c l" . org-store-link)
        ("C-c c" . org-capture)
        ("C-c a" . org-agenda))
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
  (setq org-refile-allow-creating-parent-nodes 'confirm))
