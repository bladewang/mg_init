
(setq gc-cons-threshold (* 50 1000 1000))

(setq inhibit-startup-screen t)
(menu-bar-mode -1) ;; to visit menu options,  M-x tmm-menubar

(tool-bar-mode -1)
(menu-bar-no-scroll-bar)

(fset 'yes-or-no-p 'y-or-n-p)
(column-number-mode t)
(put 'upcase-region 'disabled nil)

(defvar default-font "Iosevka Term-16.0:weight=light")
(add-to-list 'default-frame-alist `(font . ,default-font))

(setq-default auto-save-default  nil
              make-backup-files  nil
              linum-format  "%4d "
              ediff-forward-word-function  'forward-char
              diff-switches "-u")

;; set ediff control panel not to split apart from main gui frame
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;;; (setq-default default-case-fold-search nil) ;;; :set ignorecase

;;; config melpa
(require 'package)

(dolist (p '(("melpa-stable" . "http://stable.melpa.org/packages/")
             ("gnu"    . "http://elpa.gnu.org/packages/")
             ("nongnu" . "http://elpa.nongnu.org/nongnu/")))
  (add-to-list 'package-archives p t))

;;	     ("melpa"  . "http://melpa.org/packages/")
;;    ("melpa-cn" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
;;    ("org-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")

(package-initialize)

;(require 'benchmark-init)
;; To disable collection of benchmark data after init is done.
;(add-hook 'after-init-hook 'benchmark-init/deactivate)

(when (not package-archive-contents)
  (package-refresh-contents))

(when (not (package-installed-p 'use-package))
  (package-install 'use-package))

(when (not (package-installed-p 'quelpa-use-package))
  (package-install 'quelpa-use-package))

(use-package counsel
  :ensure t
  :config
  (counsel-mode)
  (ivy-mode)
  (setq ivy-use-virtual-buffers        t
	ivy-count-format      "(%d/%d) "
	enable-recursive-minibuffers   t
	minibuffer-depth-indicate-mode t)
  :bind
  ("C-M-s" . 'swiper-isearch))

(use-package j-mode
  :ensure t
  :config
  ;; for j90x
  (setq j-console-cmd "jconsole"))

(use-package undo-tree
  :ensure t
  :defer t
  :init
  (setq undo-tree-auto-save-history nil)
  :commands undo-tree-visualize
  :config
  (global-undo-tree-mode)
  :bind
  ("C-x u" . undo-tree-visualize))

(use-package ace-window
  :ensure t
  :defer t
  :bind
  ("M-o" . 'ace-window))

(use-package elpy
  ;; to activate, M-: (elpy-enable)
  :ensure t
  :commands elpy-enable
  :init
  (setq python-shell-interpreter "python3"))

(use-package view
  :defer t
  :bind
  (:map view-mode-map
   ("e" . 'View-scroll-line-forward)))

;; learned from xahlee ;; or just (require 'dired-single) than M-x dired-single-magic-buffer
;; press "o" to open file in another window
(use-package dired
  :defer t
  :config
  (put 'dired-find-alternate-file 'disabled nil)
  :bind (:map dired-mode-map
	      ("RET" . 'dired-find-alternate-file)
	      ("^" . (lambda () (interactive) (find-alternate-file "..")))))

(defvar my/packages
  '(ag                    ;A front-end for ag ('the silver searcher'), the C ack replacement.
    ;ace-window            ;Quickly switch windows.
    ;undo-tree             ;Treat undo history as a tree
    wgrep-ag              ;Writable ag buffer and apply the changes to files
    zoom                  ;Fixed and automatic balanced window layout
    pyim                  ;A Chinese input method support quanpin, shuangpin, wubi, cangjie and rime.
    pyim-basedict         ;The default pinyin dict of pyim
    dired-single          ;Reuse the current dired buffer to visit a directory
    evil                  ;Extensible Vi layer for Emacs.
    benchmark-init        ;Benchmarks Emacs require and load calls
    afternoon-theme       ;Dark color theme with a deep blue background
    spacemacs-theme       ;Color theme with a dark and light versions
    nano-theme            ;N Λ N O theme
    cyberpunk-theme       ;Cyberpunk Color Theme
    modus-themes          ;Elegant, highly legible and customizable themes
    monokai-theme         ;A fruity color theme for Emacs.
    moe-theme             ;colorful eye-candy theme. Moe, moe, kyun!
    darktooth-theme       ; the darkness... it watches
    gruvbox-theme         ;retro-groove colour theme for Emacs
    ample-theme           ;Dark Theme for Emacs
    nimbus-theme          ;An awesome dark theme
    material-theme        ;Theme based on the colors of the Google Material Design
    creamsody-theme       ;Straight from the soda fountain.
    sexy-monochrome-theme ;A sexy dark Emacs >= 24 theme for your sexy code
    tao-theme             ; package provides two parametrized uncoloured color themes for Emacs: tao-yin and tao-yang.
    ;use-package           ;A configuration macro for simplifying your .emacs
    ;counsel               ;Various completion functions using Ivy
    magit                 ;A Git porcelain inside Emacs.
    vundo                 ;Visual undo tree

    ;;; packages in melpa
;    w3m                   ;an Emacs interface to w3m
;    sicp                  ;Structure and Interpretation of Computer Programs in info format
;    phoenix-dark-mono-theme ;Monochromatic version of the Phoenix theme
;    colonoscopy-theme     ;an Emacs 24 theme based on Colonoscopy (tmTheme)
;    molokai-theme         ;molokai theme with Emacs theme engine
;    monokai-alt-theme     ;Theme with a dark background. Based on sublime monokai theme.
;    j-mode                ;Major mode for editing J programs
;    vterm                 ;Fully-featured terminal emulator
;    i-ching               ;The Book of Changes

    ;;; some other packages
    ;elpy                  ;Emacs Python Development Environment
    ;geiser                ;GNU Emacs and Scheme talk to each other
    ;geiser-chez           ;Chez Scheme's implementation of the geiser protocols
    ;;;   (setq geiser-chez-binary "chez") ;; for mac
    ;geiser-chibi          ;Chibi Scheme's implementation of the geiser protocols
    ;geiser-gambit         ;Gambit's implementation of the geiser protocols
    ;geiser-guile          ;Guile's implementation of the geiser protocols
    ;geiser-mit            ;MIT/GNU Scheme's implementation of the geiser protocols
    ;geiser-racket         ;Support for Racket in Geiser
    ;lispy                 ;vi-like Paredit

    vlf                   ;View Large Files
    qrencode              ;QRCode encoder
    ))


(dolist (pkg my/packages)
  (when (not (package-installed-p pkg))
    (package-install pkg)))

;;; for emacsclient
;;; alias em='emacsclient -t -a "emacs -Q -l ~/mg_init/init.el " '
(server-start)


(load-theme 'darktooth 1)

(setq gc-cons-threshold (* 2 1000 1000))

