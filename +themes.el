;;; +themes.el -*- lexical-binding: t; -*-

(use-package! base16-theme
  :config
  ;; TODO: Find a way to customize faces per theme
  ;; 
  ;; (custom-set-faces
  ;;  '(proof-queue-face ((t (:foreground "#eee"))))
  ;;  '(company-coq-comment-h1-face ((t (:size 1.5))))
  ;;  '(font-lock-comment-face ((t (:foreground "#333"))))
  ;;  '(proof-locked-face ((t (:background "#151515"))))
  ;;  '(proof-mouse-highlight-face  ((t (:background "#555" :foreground "#fff")))))
  )

;; The Emacs theme follows the Omarchy desktop theme (see `+omarchy.el').
;; `doom-theme' is left nil so Doom never imposes a theme of its own; the
;; Omarchy integration applies the active desktop palette after init.
(setq doom-theme nil)

;; Disable italics.
(setq doom-themes-enable-italic nil)

(defun my/disable-all-italics ()
  "Reset all faces with the italic slant."
  (dolist (face (face-list))
    (when (equal (face-attribute face :slant) 'italic)
      (set-face-attribute face nil :slant 'normal))))

(defun my/apply-custom-faces ()
  (interactive)
  (custom-set-faces!
    `(vertical-border
      :background ,(face-background 'default)
      :foreground ,(face-background 'default))
    `(fringe
      :foreground ,(face-foreground 'default)
      :background ,(face-background 'default))))

;; Run after any Doom theme load or reload.
(add-hook 'doom-load-theme-hook #'my/disable-all-italics)
(add-hook 'doom-load-theme-hook #'my/apply-custom-faces)

;; Call once explicitly if theme is already loaded:
(when (custom-theme-enabled-p doom-theme)
  (my/apply-custom-faces))
