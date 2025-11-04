;;; +org.el -*- lexical-binding: t; -*-

;; If you don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq
 org-agenda-diary-file "~/org/diary.org"
 org-directory "~/org/"
 org-agenda-files '("~/org/")
 org-modern-table 1
 org-modern-table-vertical 1)

;; Turn off some fancy stuff for org-mode to improve the performance.
;; (after! org
;;   (setq org-fontify-quote-and-verse-blocks nil
;;         org-fontify-whole-heading-line nil
;;         org-hide-leading-stars nil
;;         org-startup-indented nil))
