;;; +ui.el -*- lexical-binding: t; -*-

;; Frame background transparency.
;;
;; `alpha-background' is a pgtk frame parameter (Emacs 29+) that makes only the
;; frame background translucent; text, cursor and fringe stay fully opaque. It
;; therefore reads better than a compositor opacity rule, which fades the text
;; too. 100 = fully opaque, 0 = fully transparent background.
;;
;; Change it live with M-x my/set-frame-transparency, or edit the default below
;; and restart. The value is applied to every graphical frame and to frames
;; created later (daemon clients included).
(defvar my/frame-transparency 100
  "Background opacity of graphical frames, 0-100 (100 = opaque).")

(defun my/set-frame-transparency (&optional value)
  "Set the frame background transparency to VALUE (0-100).
Interactively, prompt for VALUE, defaulting to `my/frame-transparency'."
  (interactive
   (list (read-number "Background transparency (0-100): " my/frame-transparency)))
  (setq my/frame-transparency value)
  ;; Store it on `default-frame-alist' too, so frames created later inherit it.
  (setf (alist-get 'alpha-background default-frame-alist) value)
  (dolist (frame (frame-list))
    (when (display-graphic-p frame)
      (set-frame-parameter frame 'alpha-background value)))
  (message "Frame transparency: %d%%" value))

(defun my/adjust-frame-transparency (delta)
  "Change the frame background transparency by DELTA steps of 5."
  (my/set-frame-transparency
   (max 0 (min 100 (+ my/frame-transparency (* delta 5))))))

(defun my/frame-transparency-down ()
  "Make graphical frames 5% more transparent."
  (interactive)
  (my/adjust-frame-transparency -1))

(defun my/frame-transparency-up ()
  "Make graphical frames 5% less transparent."
  (interactive)
  (my/adjust-frame-transparency +1))

(map!
 :leader
 :desc "Frame: more transparent" "t[" #'my/frame-transparency-down
 :desc "Frame: less transparent" "t]" #'my/frame-transparency-up)

(add-hook 'after-make-frame-functions
          (lambda (frame)
            (when (display-graphic-p frame)
              (set-frame-parameter frame 'alpha-background my/frame-transparency))))

;; Apply now for frames that already exist (the initial frame, or the daemon's
;; frames); `default-frame-alist' covers the ones created later.
(my/set-frame-transparency my/frame-transparency)

;; nerd-icons (used by Doom's modeline, corfu, treemacs, ...) defaults to the
;; "Symbols Nerd Font Mono" family, which is not installed on this system, so
;; every icon rendered as a missing-glyph box showing its codepoint (e.g.
;; U+F0C13 drawn as "0F0C13" in the mode line). The installed JetBrainsMono
;; Nerd Font carries the same glyph set, so point nerd-icons at it and register
;; it, including for frames created later in the daemon.
(setq nerd-icons-font-family "JetBrainsMono Nerd Font")
(after! nerd-icons
  (when (display-graphic-p)
    (nerd-icons-set-font))
  (add-hook 'after-make-frame-functions
            (lambda (frame)
              (when (display-graphic-p frame)
                (with-selected-frame frame
                  (nerd-icons-set-font))))))

;; Doom's workspaces module pops its workspace tabline (e.g. " [1] main ")
;; into the echo area on every new frame, so it lingers as a stray bar at the
;; bottom of a freshly opened frame. Suppress that startup call only;
;; switching workspaces still shows the tabline.
(defun +ui--suppress-frame-workspace-tabline (orig &rest args)
  (cl-letf (((symbol-function '+workspace/display) #'ignore))
    (apply orig args)))
(advice-add '+workspaces-associate-frame-fn
            :around #'+ui--suppress-frame-workspace-tabline)

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
  :defer t
  :init
  (map!
   ;; Making multiple cursors should be easier.
   :nv "C-n" #'evil-mc-make-and-goto-next-match))

;; Press "%" to jump between matched tags in Emacs. For example, in HTML “<div>”
;; and “</div>” are a pair of tags. Many modern languages are supported.
;; Deferred to doom-first-buffer-hook so it activates right after startup
;; instead of blocking it, since it's a global mode with no command of its
;; own to hang an autoload off of.
(use-package! evil-matchit
  :hook (doom-first-buffer . global-evil-matchit-mode))

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
  :defer t)

(map!
 :v "v" #'er/expand-region)

(use-package! treemacs
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  ;; Keybindings live in :init (always runs) rather than :config (deferred
  ;; until treemacs loads) -- otherwise nothing would ever trigger the load.
  (map!
   :leader
   :desc "Treemacs toggle" "e" #'+treemacs/toggle
   :desc "Treemacs locate" "r" #'treemacs-select-window)
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
       (treemacs-git-mode 'simple)))))
