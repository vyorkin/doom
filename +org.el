;;; +org.el -*- lexical-binding: t; -*-

(use-package org
  :init
  ;; If you don't want your org files in the default location below,
  ;; change `org-directory'. It must be set before org loads!
  (setq
   org-agenda-diary-file "~/org/diary.org"
   org-directory "~/org/"
   org-agenda-files '("~/org/")
   org-modern-table 1
   org-modern-table-vertical 1)
  :config
  (map!
   :leader
   :mode org-mode-map
   :desc "Toggle link display" "tl" #'org-toggle-link-display))


;; Turn off some fancy stuff for org-mode to improve the performance.
;; (after! org
;;   (setq org-fontify-quote-and-verse-blocks nil
;;         org-fontify-whole-heading-line nil
;;         org-hide-leading-stars nil
;;         org-startup-indented nil))
