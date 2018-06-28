
;;; add by wky
;;; init file work with spacemac

(menu-bar-mode -1)
(global-hl-line-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)

(setq-default auto-save-default  nil
              make-backup-files  nil
              linum-format  "%4d "
              ediff-forward-word-function  'forward-char)

;;; (setq-default default-case-fold-search nil) ;;; :set ignorecase

;; (set-face-background 'hl-line "color-19")
;; (set-face-background 'hl-line "black")
;; (set-face-foreground 'hl-line "white")

;; (set-face-background 'region "color-160")
(set-face-background 'region "red")
(set-face-foreground 'region "white")

;;; config melpa
(require 'package)
(add-to-list
 'package-archives
 '("melpa" . "http://melpa.org/packages/")
 t)
(package-initialize)

(window-numbering-mode)

;;; keys binding
; (global-set-key (kbd "C-SPC") nil)
; (global-set-key (kbd "C-@") 'set-mark-command)
(global-set-key (kbd "C-x C-q") 'read-only-mode)

(setq term-buffer-maximum-size 0)

(load-theme 'afternoon t)
