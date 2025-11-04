;;; +base.el -*- lexical-binding: t; -*-

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

;; Make sure we don't use native fullscreen.
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
  :commands
  (global-prettify-symbols-mode)
  :init
  (setq prettify-symbols-unprettify-at-point 'right-edge)
  :config
  ;; Convert certain words into symbols, e.g. lambda becomes λ.
  (global-prettify-symbols-mode t))

(use-package! calendar
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
  :custom
  (visual-fill-column-center-text t)
  :hook
  (visual-line-mode . visual-fill-column-mode))
