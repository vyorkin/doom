;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
 
(setq
 user-full-name "Vasiliy Yorkin"
 user-mail-address "vasiliy.yorkin@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "JuliaMono" :size 18))
;; (setq doom-font (font-spec :family "Terminess Nerd Font Mono" :size 18))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'base16-black-metal)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq ns-use-native-fullscreen nil)

;; Start the initial frame in fullscreen mode
(add-to-list 'initial-frame-alist '(fullscreen . fullscreen))

;; To use tab-bar-notch we must be using tab-bar-mode,
;; with the tab-bar visible at the top of the frame above all buffers.
(setq
 tab-bar-format
 '(tab-bar-format-history
   tab-bar-format-tabs
   tab-bar-separator
   tab-bar-format-add-tab
   tab-bar-notch-spacer))
(tab-bar-mode)

;; Helps deal with the tab bar notch on new macbooks.
(use-package! tab-bar-notch)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;; Line-numbers may slow down scrolling.
(setq display-line-numbers-type nil)

;; Disable italics.
(setq doom-themes-enable-italic nil)

(defun my/disable-all-italics ()
  "Reset all faces with the italic slant."
  (dolist (face (face-list))
    (when (equal (face-attribute face :slant) 'italic)
      (set-face-attribute face nil :slant 'normal))))

(defun my/apply-custom-faces ()
  (custom-set-faces!
    `(vertical-border
      :background ,(face-background 'default)
      ;; TODO: Not perfect, I want `,(face-foreground 'default)` here as well
      :foreground "#000000")
    `(fringe
      :foreground ,(face-foreground 'default)
      :background ,(face-background 'default))))

;; Run after any Doom theme load or reload.
(add-hook 'doom-load-theme-hook #'my/disable-all-italics)
(add-hook 'doom-load-theme-hook #'my/apply-custom-faces)

;; Call once explicitly if theme is already loaded:
(when (custom-theme-enabled-p doom-theme)
  (my/apply-custom-faces))

;; Do not ask for confirmation, just close the Emacs.
(setq confirm-kill-emacs nil)

;; More procedural scrolling.
(setq
 auto-window-vscroll nil
 hscroll-margin 5
 hscroll-step 5
 scroll-conservatively 101
 scroll-margin 0
 scroll-preserve-screen-position t)
(setq-default
 scroll-down-aggressively 0.01
 scroll-up-aggressively 0.01)

;; Remember only 10 last files and clean up regularly.
(setq
 recentf-auto-cleanup "11:00pm"
 recentf-max-saved-items 10
 recentf-filename-handlers '(file-truename abbreviate-file-name))

(use-package! prog-mode
  :defer t
  :commands
  (global-prettify-symbols-mode)
  :init
  (setq prettify-symbols-unprettify-at-point 'right-edge)
  :config
  ;; Convert certain words into symbols, e.g. lambda becomes λ.
  (global-prettify-symbols-mode t))

(use-package! calendar
  :defer t
  :ensure nil
  :custom (calendar-week-start-day 1))

;; Hide cursor in inactive windows.
(setq-default cursor-in-non-selected-windows nil)

;; Display vertical bar cursor with default width.
;; Draw block cursor as wide as the glyph under it.
(setq-default
 cursor-type 'bar
 x-stretch-cursor t)

;; Show full path in the title bar.
(setq-default frame-title-format "%b (%f)")

;; Set fringe size.
(fringe-mode '(12 . 12))

;; Setup fringes on both sides and display an indicator for buffer boundaries on the left side.
;; Display fringes outside margins to have the padding on the inside.
(setq-default
 fringes-outside-margins t
 left-fringe-width 8
 right-fringe-width 8
 indicate-buffer-boundaries 'right)

;; Remove continuation arrow on right fringe.
(setq-default
 fringe-indicator-alist
 (delq (assq 'continuation fringe-indicator-alist) fringe-indicator-alist))

;; Set left and right margins for every window.
(setq-default
 left-margin-width 1
 right-margin-width 1)

;; Hide the window-divider (a line separating windows).
(when (boundp 'window-divider-mode)
  (setq
   window-divider-default-places t
   window-divider-default-bottom-width 0
   window-divider-default-right-width 0)
  (window-divider-mode +1))

;; Give some more room to the minibuffer.
(setq max-mini-window-height 0.3)

;; One tab is 2 spaces.
(setq-default tab-width 2)

;; Non-zero values for line-spacing can mess up ansi-term and co,
;; so we zero it explicitly in those cases.
(add-hook
 'term-mode-hook
 (lambda () (setq line-spacing 0)))

;; Treat an Emacs region much like a typical text selection outside of Emacs.
(setq delete-selection-mode t)

;; Wrap lines according to fill-column in visual-line-mode.
(use-package! visual-fill-column
  :defer t
  :custom
  (visual-fill-column-center-text t)
  :hook
  (visual-line-mode . visual-fill-column-mode))

(load! "+keys")
(load! "+projectile")
(load! "+org")

;; Theorem proving.
(load! "+coq")
(load! "+lean")

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

(use-package! rainbow-identifiers
  :hook
  (prog-mode . rainbow-identifiers-mode))

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

(use-package! treemacs
  :config
  (setq treemacs-no-png-images t)
  ;; The default width and height of the icons is 22 pixels.
  (treemacs-resize-icons 14)
  (treemacs-follow-mode t)
  (treemacs-fringe-indicator-mode 'always)
  (map!
   :leader
   :desc "Treemacs toggle" "e" #'+treemacs/toggle
   :desc "Treemacs locate" "r" #'treemacs-select-window))

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
   :v "v" 'er/expand-region))

;; Popup commit message for current line.
(use-package! git-messenger
  :config
  (map!
    :leader
    :desc "Popup commit message for current line" "gm" #'git-messenger:popup-message))

(use-package! magit
  :defer t
  :custom
  (magit-refs-show-commit-count 'all)
  (magit-save-repository-buffers 'dontask)
  (git-messenger:use-magit-popup t)
  :config
  ;; Unset pager as it is not supported properly inside emacs
  (setenv "GIT_PAGER" "")
  (map!
   :leader
   :desc "Git status" "gs" #'magit-status
   :desc "Git pull" "gp" #'magit-pull
   :desc "Git push" "gP" #'magit-push
   :desc "Git diff" "gdd" #'magit-diff
   :desc "Git diff buffer file" "gdf" #'magit-diff-buffer-file))
