;;; lean.el -*- lexical-binding: t; -*-

;; Lazy loading.
(require 'nael-autoloads)
(require 'nael-lsp-autoloads)

;; Enables abbreviations as well as LSP automatically.
(add-hook 'nael-mode-hook #'abbrev-mode)
(add-hook 'nael-mode-hook #'eglot-ensure)

(defun my/nael/setup ()
  (interactive)
  (setq eldoc-echo-area-use-multiline-p nil))

(add-hook 'nael-mode-hook #'my/nael/setup)
