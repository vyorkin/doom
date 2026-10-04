;;; +omarchy.el --- Follow the Omarchy desktop theme -*- lexical-binding: t; -*-

;; Keep Emacs' theme in sync with the Omarchy desktop theme.
;;
;; Omarchy renders the active theme's resolved palette into `omarchy-colors.el'
;; under the current theme directory (Omarchy 4 keeps it in ~/.local/state,
;; Omarchy 3 under ~/.config). This module loads that palette and enables the
;; bundled `omarchy' theme once Doom has finished initializing, then watches
;; `theme.name' so a desktop theme switch is picked up without restarting
;; Emacs.
;;
;; Only the theme is synchronized here. Fonts are left to Doom, unlike the
;; omarchy-emacs package hook which syncs both.

(require 'cl-lib)
(require 'filenotify)

(defconst +omarchy--current-base
  (let ((candidates '("~/.local/state/omarchy/current"
                      "~/.config/omarchy/current")))
    (or (cl-find-if (lambda (d) (file-directory-p (expand-file-name "theme" d)))
                    candidates)
        (car candidates)))
  "Directory holding Omarchy's current theme assets.")

(defconst +omarchy--theme-dir
  (expand-file-name "theme" +omarchy--current-base)
  "Directory with the active Omarchy theme's generated assets.")

(defconst +omarchy--theme-name-file
  (expand-file-name "theme.name" +omarchy--current-base)
  "File holding the active Omarchy theme name; watched for theme changes.")

;; The bundled theme reads `(require 'omarchy-colors)' and lives both in the
;; omarchy-emacs user config and, as a fallback, in the package itself.
(add-to-list 'load-path +omarchy--theme-dir)
(add-to-list 'custom-theme-load-path "~/.config/emacs/themes")
(add-to-list 'custom-theme-load-path "/usr/share/omarchy-emacs/config/themes" :append)

(defun +omarchy-apply-theme ()
  "Load the current Omarchy palette and enable the `omarchy' theme."
  (interactive)
  (let ((colors-file (expand-file-name "omarchy-colors.el" +omarchy--theme-dir)))
    (when (file-exists-p colors-file)
      ;; omarchy-colors.el `setq's only the colors its template rendered, so
      ;; clear the semantic ones first: a switch from a semantic theme to a
      ;; legacy color0..15 one would otherwise keep the previous values.
      (dolist (sym '(omarchy-color-muted omarchy-color-selection
                     omarchy-color-dark-fg omarchy-color-light-fg
                     omarchy-color-bright-fg omarchy-color-dark-bg
                     omarchy-color-darker-bg omarchy-color-lighter-bg
                     omarchy-color-orange))
        (makunbound sym))
      (load-file colors-file)
      ;; Rebuild the theme from scratch so no stale faces survive.
      (dolist (theme '(omarchy omarchy-dark omarchy-light))
        (disable-theme theme)
        (put theme 'theme-settings nil)
        (setq custom-known-themes (delq theme custom-known-themes)))
      (load-file (locate-file "omarchy-theme" custom-theme-load-path '(".el")))
      (enable-theme 'omarchy))))

(defvar +omarchy--watch nil
  "File notification descriptor for `+omarchy--theme-name-file'.")

(defun +omarchy--watch-theme ()
  "Watch the Omarchy theme name file and re-apply on change.
`omarchy-theme-set' rewrites `theme.name' in place, so a watch on the file
itself survives the theme switch, unlike a watch on the swapped theme dir."
  (when (and (file-exists-p +omarchy--theme-name-file)
             (not +omarchy--watch))
    (setq +omarchy--watch
          (file-notify-add-watch
           +omarchy--theme-name-file '(change)
           (lambda (_event) (+omarchy-apply-theme))))))

;; Apply once Doom is done initializing (the daemon included), and keep
;; watching for later desktop theme changes.
(add-hook 'doom-after-init-hook #'+omarchy-apply-theme -90)
(+omarchy--watch-theme)

;;; +omarchy.el ends here
