;;; +rust.el --- Rust development config -*- lexical-binding: t; -*-

;; rust-analyzer eglot settings — scoped to Rust buffers only.
(after! eglot
  (add-to-list 'eglot-server-programs
               '(rustic-mode . ("rust-analyzer" :initializationOptions
                                (:check (:command "clippy")
                                 :procMacro (:enable t
                                             :attributes (:enable t))
                                 :cargo (:allFeatures t
                                         :buildScripts (:enable t))
                                 :files (:excludeDirs ["target"])
                                 :inlayHints (:typeHints (:enable t)
                                              :parameterHints (:enable t)
                                              :chainingHints (:enable t)
                                              :closingBraceHints (:enable t :minLines 10)
                                              :closureReturnTypeHints (:enable "with_block")
                                              :discriminantHints (:enable "fieldless")
                                              :lifetimeElisionHints (:enable "skip_trivial"
                                                                     :useParameterNames t)
                                              :bindingModeHints (:enable t)))))))

;; Run tests via nextest instead of plain `cargo test', and set up
;; inlay hints toggle + debug keybindings.
(after! rustic
  (setq rustic-cargo-test-runner 'nextest)

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
