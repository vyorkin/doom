;;; +lean.el -*- lexical-binding: t; -*-

(use-package! nael-mode
  :mode "\\.lean\\'"
  :hook ((nael-mode . abbrev-mode)
         (nael-mode . eglot-ensure))
  :config
  (setq eldoc-echo-area-use-multiline-p nil))
