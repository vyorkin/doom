;;; other.el -*- lexical-binding: t; -*-

(use-package treemacs
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq
     treemacs-no-png-images t
     treemacs-wide-toggle-width 38
     treemacs-width 20)

    ;; The default width and height of the icons is 22 pixels.
    ;; If you are using a Hi-DPI display, uncomment this to double the icon size.
    (treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))

  (map!
   :leader
   :desc "Treemacs toggle" "e" #'+treemacs/toggle
   :desc "Treemacs locate" "r" #'treemacs-select-window))
