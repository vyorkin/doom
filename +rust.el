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

  ;; rust-analyzer returns definitions inside third-party crate sources under
  ;; ~/.cargo/{registry,git}. Eglot treats each such directory as its own
  ;; project and boots a separate, expensive rust-analyzer for it (10s+ and
  ;; ~1.5GB per crate, because it re-runs cargo check/clippy with all features
  ;; from scratch). Skip LSP for those read-only sources; they open without a
  ;; server, and `M-x eglot' can still be run manually when full navigation
  ;; inside a dependency is needed.
  (defadvice! +rust--skip-lsp-for-dependency-sources-a (fn &rest args)
    :around #'rustic-setup-lsp
    (unless (and buffer-file-name
                 (string-match-p "/\\.cargo/\\(registry\\|git\\)/\\|/\\.rustup/"
                                 (expand-file-name buffer-file-name)))
      (apply fn args)))

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
