;;; lean.el -*- lexical-binding: t; -*-

;; Lazy loading.
(require 'nael-autoloads)
(require 'nael-lsp-autoloads)
;; Enables abbreviations as well as LSP automatically.
(add-hook 'nael-mode-hook #'abbrev-mode)
(add-hook 'nael-mode-hook #'eglot-ensure)

(after! nael
  (map! :map nael-mode-map
        :leader
        "tt" #'eldoc-doc-buffer))
