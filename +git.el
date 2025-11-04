;;; +git.el -*- lexical-binding: t; -*-

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
