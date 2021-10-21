(use-package flycheck
:init (global-flycheck-mode))

(use-package eglot)
(add-to-list 'eglot-server-programs
             `(python-mode . ("pyls" "-v" "--tcp" "--host"
                              "localhost" "--port" :autoport)))
(add-hook 'python-mode-hook 'eglot-ensure)
