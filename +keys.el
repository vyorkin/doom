;;; +keys.el -*- lexical-binding: t; -*-

(after! evil
  (map!
   :n "C-h" #'evil-window-left
   :n "C-j" #'evil-window-down
   :n "C-k" #'evil-window-up
   :n "C-l" #'evil-window-right
   :n "C-M-l" #'evil-window-increase-width
   :n "C-M-h" #'evil-window-decrease-width
   :n "C-M-k" #'evil-window-increase-height
   :n "C-M-j" #'evil-window-decrease-height
   ;; Easier search (my old habbits)
   :n "C-s" #'+default/search-buffer
   ;; Swap : and ; to make colon commands easier to type in Emacs.
   :n ";" #'evil-ex
   :n ":" #'evil-repeat-find-char)
  (map!
   :map messages-buffer-mode-map
   ;; Remap 0 for convenience.
   :n "0" #'evil-digit-argument-or-evil-beginning-of-line)
  ;; Process menu
  (map!
   :map process-menu-mode-map
   :n "M-d" #'process-menu-delete-process
   :n "q" 'kill-buffer-and-window)
  (map!
   :map org-mode-map
   :n "C-j" #'evil-window-down
   :n "C-k" #'evil-window-up))

(after! treemacs-evil
  (define-key evil-treemacs-state-map (kbd "C-h") #'evil-window-left)
  (define-key evil-treemacs-state-map (kbd "C-j") #'evil-window-down)
  (define-key evil-treemacs-state-map (kbd "C-k") #'evil-window-up)
  (define-key evil-treemacs-state-map (kbd "C-l") #'evil-window-right)
  (define-key evil-treemacs-state-map (kbd "e") #'treemacs-extra-wide-toggle)
  (define-key evil-treemacs-state-map (kbd "S") #'treemacs-visit-node-vertical-split)
  (define-key evil-treemacs-state-map (kbd "s") #'treemacs-visit-node-horizontal-split))

;; Leader-prefixed
(map!
 :leader
 :desc "Split window right" "|" #'split-window-right
 :desc "Split window below" "-" #'split-window-below 
 :desc "Eval expression" "Ee" #'eval-expression
 :desc "List processes" "P" #'list-processes)
