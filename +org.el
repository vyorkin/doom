;;; +org.el -*- lexical-binding: t; -*-

;; Turn off some fancy stuff for org-mode to improve the performance.
;; (after! org
;;   (setq org-fontify-quote-and-verse-blocks nil
;;         org-fontify-whole-heading-line nil
;;         org-hide-leading-stars nil
;;         org-startup-indented nil))

(after! org
  (setq
   org-agenda-diary-file "~/org/diary.org"
   org-directory "~/org/"
   org-agenda-files '("~/org/")
   org-modern-table 1
   org-modern-table-vertical 1))

