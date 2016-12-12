
;;; add by wky

(menu-bar-mode -1)
(setq auto-save-default nil)
(setq make-backup-files nil)
(fset 'yes-or-no-p 'y-or-n-p)
;;; (setq default-case-fold-search nil) ;;; :set ignorecase

;; (require 'linum)
;; (set-face-foreground 'linum "magenta")
(setq linum-format "%4d ")

;; set charactor level diff
(setq-default ediff-forward-word-function 'forward-char)

(global-hl-line-mode 1)
;; (set-face-background 'hl-line "color-19")
(set-face-background 'hl-line "blue")
(set-face-foreground 'hl-line "white")

;; (set-face-background 'region "magenta")
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
