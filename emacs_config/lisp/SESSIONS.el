;; Save miscellaneous history
(setq savehist-additional-variables
      '(kill-ring
        command-history
        set-variable-value-history
        custom-variable-history   
        query-replace-history     
        read-expression-history   
        minibuffer-history        
        read-char-history         
        face-name-history         
        bookmark-history          
        ivy-history               
        counsel-M-x-history       
        file-name-history         
        counsel-minibuffer-history))
(setq history-length 250)
(setq kill-ring-max 25)
(put 'minibuffer-history         'history-length 50)
(put 'file-name-history          'history-length 50)
(put 'set-variable-value-history 'history-length 25)
(put 'custom-variable-history    'history-length 25)
(put 'query-replace-history      'history-length 25)
(put 'read-expression-history    'history-length 25)
(put 'read-char-history          'history-length 25)
(put 'face-name-history          'history-length 25)
(put 'bookmark-history           'history-length 25)
(put 'ivy-history                'history-length 25)
(put 'counsel-M-x-history        'history-length 25)
(put 'counsel-minibuffer-history 'history-length 25)
(setq savehist-file "~/.local/share/emacs/savehist")
(savehist-mode 1)

;; Remove text properties for kill ring entries
;; See https://emacs.stackexchange.com/questions/4187
(defun unpropertize-kill-ring ()
  (setq kill-ring (mapcar 'substring-no-properties kill-ring)))
(add-hook 'kill-emacs-hook 'unpropertize-kill-ring)

;; Recentf files 
(setq recentf-max-menu-items 25)
(setq recentf-save-file     "~/.local/share/emacs/recentf")
(recentf-mode 1)

;; Bookmarks
(setq bookmark-default-file "~/.local/share/emacs/bookmark")
;; Undo file
(setq auto-save-file-name-transforms
      '((".*" "~/.local/share/emacs/undo/" t)))
;; Saving persistent tree-undo to a single directory
(setq undo-tree-history-directory-alist     
      '(("." . "~/.local/share/emacs/undo-tree")))
;; Backup
(setq backup-directory-alist '(("." . "~/.local/share/emacs/backups"))
      make-backup-files t     ; backup of a file the first time it is saved.
      backup-by-copying t     ; don't clobber symlinks
      version-control t       ; version numbers for backup files
      delete-old-versions t   ; delete excess backup files silently
      kept-old-versions 6     ; oldest versions to keep when a new numbered
                                        ;  backup is made (default: 2)
      kept-new-versions 9     ; newest versions to keep when a new numbered
                                        ;  backup is made (default: 2)
      auto-save-default t     ; auto-save every buffer that visits a file
      auto-save-timeout 20    ; number of seconds idle time before auto-save
                                        ;  (default: 30)
      auto-save-interval 200)  ; number of keystrokes between auto-saves
                                        ;  (default: 300)
;; Saving my sessions in another folder.
(setq auto-save-list-file-prefix            
      "~/.local/share/emacs/sessions/session-")
(setq auth-sources '("~/.local/share/emacs/authinfo"
                     "~/.local/share/emacs/authinfo.gpg"
                     "~/.authinfo"
                     "~/.authinfo.gpg"
                     "~/.netrc" ))
