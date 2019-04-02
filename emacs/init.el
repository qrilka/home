(package-initialize)

;; UI
(tool-bar-mode -1)
(menu-bar-mode -1)
(set-default-font "LiberationMono-10")
(use-package railscasts-reloaded-theme
  :ensure t
  :init
  (load-theme 'railscasts-reloaded t))
(blink-cursor-mode 0)
;; inital view
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)

;; recentf
(use-package recentf
  :config
  (recentf-mode 1)
  (setq recentf-max-menu-items 20)
  :init
  (global-set-key "\C-x\C-r" 'recentf-open-files))

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

(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))
