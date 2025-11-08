;;; +ui.el -*- lexical-binding: t; -*-

;; This is a "rainbow parentheses"-like mode which highlights
;; delimiters such as parentheses, brackets or braces according to their depth.
;; Each successive level is highlighted in a different color. This makes it easy
;; to spot matching delimiters, orient yourself in the code, and tell which
;; statements are at a given depth.
(use-package! rainbow-delimiters
  :commands
  (rainbow-delimiters-unmatched-face)
  :config
  ;; Pastels
  (set-face-attribute 'rainbow-delimiters-depth-1-face nil :foreground "#78c5d6")
  (set-face-attribute 'rainbow-delimiters-depth-2-face nil :foreground "#bf62a6")
  (set-face-attribute 'rainbow-delimiters-depth-3-face nil :foreground "#459ba8")
  (set-face-attribute 'rainbow-delimiters-depth-4-face nil :foreground "#e868a2")
  (set-face-attribute 'rainbow-delimiters-depth-5-face nil :foreground "#79c267")
  (set-face-attribute 'rainbow-delimiters-depth-6-face nil :foreground "#f28c33")
  (set-face-attribute 'rainbow-delimiters-depth-7-face nil :foreground "#c5d647")
  (set-face-attribute 'rainbow-delimiters-depth-8-face nil :foreground "#f5d63d")
  (set-face-attribute 'rainbow-delimiters-depth-9-face nil :foreground "#78c5d6")
  ;; Make unmatched parens stand out more
  (set-face-attribute
   'rainbow-delimiters-unmatched-face nil
   :foreground 'unspecified
   :inherit 'show-paren-mismatch
   :strike-through t)
  (set-face-foreground 'rainbow-delimiters-unmatched-face "magenta")
  :hook
  (prog-mode . rainbow-delimiters-mode))

;; Turn on if you like clown fiesta
;; (use-package! rainbow-identifiers
;;   :hook
;;   (prog-mode . rainbow-identifiers-mode))

;; Basically its the same as highlight-thing but seems to be smarter and less distracting.
(use-package! idle-highlight-mode
  :custom
  (idle-highlight-idle-time 0.5)
  :hook
  (prog-mode . idle-highlight-mode)
  :config
  (map!
   :leader
   :desc "Toggle idle highlight" "tH" #'idle-highlight-mode))

;; Provides a local minor mode (toggled by ~M-x hl-line-mode~) and a global
;; minor mode (toggled by ~M-x global-hl-line-mode~) to highlight, on a suitable
;; terminal, the line on which point is.

(use-package! hl-line
  :custom
  ;; Only highlight in selected window
  (hl-line-sticky-flag nil)
  (global-hl-line-sticky-flag nil)
  :config
  (set-face-background 'hl-line "#151515")
  (global-hl-line-mode)
  (map!
    :leader
    :desc "Toggle line highlight" "tL" #'global-hl-line-mode))

(use-package! evil-mc
  :config
  (map!
   ;; Making multiple cursors should be easier.
   :nv "C-n" #'evil-mc-make-and-goto-next-match))

;; Press "%" to jump between matched tags in Emacs. For example, in HTML “<div>”
;; and “</div>” are a pair of tags. Many modern languages are supported.
(use-package! evil-matchit
  :defer t
  :commands
  (evilmi-jump-items
   evilmi-text-object
   global-evil-matchit-mode)
  :config
  (global-evil-matchit-mode 1))

;; Zoom a window to display as a single window temporarily.
(use-package! zoom-window
  :custom
  (zoom-window-mode-line-color "#000000")
  :config
  (map!
    :leader
    :desc "Zoom window" "RET" #'zoom-window-zoom))

;; Increases the selected region by semantic units.
(use-package! expand-region
  :defer t
  :config
  (map!
   :v "v" #'er/expand-region))
