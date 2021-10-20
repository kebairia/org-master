;;; package --- Summary  
;; Load configuration from ~/.config/emacs/lisp/*.el

              ;;; Commentary:
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;; Speed up startup
(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)
(add-hook 'after-init-hook
          `(lambda ()
             (setq gc-cons-threshold 800000
                   gc-cons-percentage 0.1)
             (garbage-collect)) t)

;; load files
(load "/root/.config/emacs/lisp/DEFAULTS.el") 
;; (load "~/.config/emacs/lisp/PACKAGES.el") 
;; (load "~/.config/emacs/lisp/SESSIONS.el") 
(load "/root/.config/emacs/lisp/BINDINGS.el") 
;; (load "~/.config/emacs/lisp/ORG.el") 
;; (load "~/.config/emacs/lisp/ORG-ROAM.el") 
;; (load "~/.config/emacs/lisp/PYTHON.el") 
;;(load "~/.config/emacs/lisp/MU4E.el") 
;; (load "~/.config/emacs/nano/nano.el") 	;
;; (load "~/.config/emacs/nano/nano-layout.el") 
;; (load "~/.config/emacs/nano/nano-modeline.el") 
;; (add-to-list 'load-path "~/.config/emacs/emacs-reveal")
;; (require 'emacs-reveal)

;; Measure emacs startup time
(add-to-list 'after-init-hook
             (lambda ()
               (message (concat "emacs ("
                                (number-to-string (emacs-pid))
                                ") started in "
                                (emacs-init-time)))))

(defun enable-writing-minor-modes ()
  "Enable flyspell and visual line mode for calling from mode hooks"
  (visual-line-mode 1)
  (flyspell-mode 1))
