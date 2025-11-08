;;; +projectile.el -*- lexical-binding: t; -*-

(use-package! projectile
  :init
  (setq
   projectile-sort-order 'recently-active
   projectile-use-git-grep t

   ;; Just in case I'll have problems with caching in the future -
   ;; try uncommenting this line below to disable the persitent cache.
   ;; projectile-enable-caching t

   projectile-file-exists-remote-cache-expire (* 10 60)
   projectile-file-exists-local-cache-expire (* 5 60)
   projectile-project-search-path
   '("~/projects/learn/coq/"
     "~/projects/learn/lean4/"
     "~/projects/learn/go/"
     "~/projects/learn/rust/"
     "~/projects/learn/zig/"
     "~/projects/learn/defi/"
     "~/projects/learn/ocaml/"
     "~/projects/play/"
     "~/projects/work/zerion/"
     "~/projects/github/coq/"
     "~/projects/github/lean4/"
     "~/projects/personal/"
     "~/projects/opensource/"
     "~/projects/work/mev/"))
  :config
  (map!
   :leader
   :desc "Run async shell cmd in project's root" "!" #'projectile-run-async-shell-command-in-root
   :desc "Clear cache of project files" "DEL" #'projectile-invalidate-cache))

