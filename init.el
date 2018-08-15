
;;; add by wky

(menu-bar-mode -1)
(global-hl-line-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)

(setq-default auto-save-default  nil
              make-backup-files  nil
              linum-format  "%4d "
              ediff-forward-word-function  'forward-char
              diff-switches "-u")

;;; (setq-default default-case-fold-search nil) ;;; :set ignorecase

;; (set-face-background 'hl-line "color-19")
(set-face-background 'hl-line "black")
;; (set-face-foreground 'hl-line "white")
(add-hook 'linum-mode-hook (lambda () (set-face-foreground 'linum "magenta")))

;; (set-face-background 'region "color-160")
(set-face-background 'region "red")
(set-face-foreground 'region "white")
(set-face-foreground 'minibuffer-prompt "white")

;;; config melpa
(require 'package)
(add-to-list
 'package-archives
 '("melpa" . "http://melpa.org/packages/")
 t)
(package-initialize)

(window-numbering-mode)
(global-undo-tree-mode)

;;; keys binding
; (global-set-key (kbd "C-SPC") nil)
; (global-set-key (kbd "C-@") 'set-mark-command)
(global-set-key (kbd "M-r") 'move-to-window-line-top-bottom)
(global-set-key (kbd "C-x C-q") 'read-only-mode)

(setq term-buffer-maximum-size 0)
(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("28ec8ccf6190f6a73812df9bc91df54ce1d6132f18b4c8fcc85d45298569eb53" default)))
 '(package-selected-packages
   (quote
    (markdown-mode window-numbering web-server w3m undo-tree sicp magit afternoon-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
