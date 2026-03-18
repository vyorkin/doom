;;; +rust.el --- Rust development config -*- lexical-binding: t; -*-

;; rust-analyzer eglot settings — scoped to Rust buffers only.
(after! eglot
  (add-to-list 'eglot-server-programs
               '(rustic-mode . ("rust-analyzer" :initializationOptions
                                (:check (:command "clippy")
                                 :procMacro (:enable t)
                                 :cargo (:allFeatures t)
                                 :inlayHints (:typeHints (:enable t)
                                              :parameterHints (:enable t)
                                              :chainingHints (:enable t)))))))

;; Inlay hints toggle + debug keybindings.
(after! rustic
  (map! :map rustic-mode-map
        :localleader
        "i" #'eglot-inlay-hints-mode
        (:prefix ("d" . "debug")
         "d" #'dape
         "b" #'dape-breakpoint-toggle
         "c" #'dape-continue
         "n" #'dape-next
         "s" #'dape-step-in
         "o" #'dape-step-out
         "q" #'dape-quit)))
