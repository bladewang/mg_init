;; for Emacs 2.9
(setq gc-cons-threshold (* 50 1000 1000))

(setq inhibit-startup-screen t)
(menu-bar-mode -1) ;; to visit menu options,  M-x tmm-menubar

(tool-bar-mode -1)
(scroll-bar-mode -1)


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

;;; C-u C-SPC C-SPC C-SPC ...
;;; or Cu C-@ C-@ C-@ ...
(setq set-mark-command-repeat-pop t)

;;; config melpa
(require 'package)

;;    ("gnu"    . "https://elpa.gnu.org/packages/")
;;    ("nongnu" . "https://elpa.nongnu.org/nongnu/")
;;    ("melpa-stable" . "https://stable.melpa.org/packages/")
;;    ("melpa"  . "https://melpa.org/packages/")

(dolist (p '(
	     ("melpa"  . "https://melpa.org/packages/")
	     ("melpa-stable" . "https://stable.melpa.org/packages/")
	     ))
  (add-to-list 'package-archives p t))
(package-initialize)

;(require 'benchmark-init)
;; To disable collection of benchmark data after init is done.
;(add-hook 'after-init-hook 'benchmark-init/deactivate)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(unless (package-installed-p 'quelpa-use-package)
  (package-install 'quelpa-use-package))

(unless (package-installed-p 'vc-use-package)
  (package-vc-install "https://github.com/slotThe/vc-use-package"))
(require 'vc-use-package)

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

(use-package register-jump
  :vc (:fetcher github :repo leoliu/register-jump.el)
  :defer t
  :init
  (define-key ctl-x-r-map "j" 'register-jump))

(use-package j-mode
  :pin melpa
  :defer t
  :config
  ;; for j90x
  (setq j-console-cmd "jconsole"))

(use-package magit
  :defer t
  :pin melpa)

(use-package vterm
  :defer t
  :pin melpa
  :init
  (setq vterm-max-scrollback 100000)
  :bind*
  ;; input C-x to vterm by C-q C-x
  ;; ("C-q" . 'vterm-send-next-key)
  ;; C-q bind to quoted-insert by defult
  ;;     ,use :map to limit the map just bind in vterm
  (:map vterm-mode-map
	("C-q" . 'vterm-send-next-key)))

(use-package nov
  :defer t
  :pin melpa
  :init
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))

(use-package meow
  :defer t
  :init
  (defun my/map-meow-insert-exit ()
    (define-key meow-insert-state-keymap (kbd "ESC") 'meow-insert-exit))
  (add-hook 'meow-global-mode-hook 'my/map-meow-insert-exit))

(use-package undo-tree
  :ensure t
  :defer t
  :init
  (setq undo-tree-auto-save-history nil)
  :commands undo-tree-visualize
  :config
  (global-undo-tree-mode)
  :bind
  ("C-x u" . 'undo-tree-visualize))

(use-package ace-window
  :ensure t
  :defer t
  :bind
  ("M-o" . 'ace-window))

(use-package elpy
  ;; to activate, M-: (elpy-enable)
  :defer t
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

(use-package image
  :defer t
  :init
  (defun my/center-image ()
    "hook function to display image on the center of window"
    (let* ((window-width  (window-total-width))
           (window-height (window-total-height))
	   (image-width   (car (image-size (image-get-display-property))))
           (image-height  (cdr (image-size (image-get-display-property))))
           (margin-width  (truncate (/ (- window-width  image-width)  2)))
           (margin-height (truncate (/ (- window-height image-height) 2)))
	   (inhibit-read-only t))
      (progn (goto-line 1)
	     (insert (make-string margin-height ?\n))
	     (goto-line (+ 1 margin-height))
	     (insert (make-string margin-width ?\s)))
      (set-buffer-modified-p nil)))
  (add-hook 'image-mode-hook 'my/center-image))

(use-package calendar
  :defer t
  :config
  (calendar-set-date-style 'iso))

(defvar my/packages
  ;;; packages in elpa & melpa-stable
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
    monokai-theme         ;A fruity color theme for Emacs.
    darktooth-theme       ; the darkness... it watches
    ample-theme           ;Dark Theme for Emacs
    material-theme        ;Theme based on the colors of the Google Material Design
    creamsody-theme       ;Straight from the soda fountain.
    sexy-monochrome-theme ;A sexy dark Emacs >= 24 theme for your sexy code
    tao-theme             ; package provides two parametrized uncoloured color themes for Emacs: tao-yin and tao-yang.
    ;use-package           ;A configuration macro for simplifying your .emacs
    ;counsel               ;Various completion functions using Ivy
    ;magit                 ;A Git porcelain inside Emacs.
    vundo                 ;Visual undo tree
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
    ;sml-mode              ;Major mode for editing (Standard) ML
    lispy                 ;vi-like Paredit
    vlf                   ;View Large Files
    qrencode              ;QRCode encoder
    ))

(defvar my/packages-melpa
  '(;;; packages in melpa
    magit                 ;A Git porcelain inside Emacs.
    w3m                   ;an Emacs interface to w3m
    nov                   ;Featureful EPUB reader mode
    sicp                  ;Structure and Interpretation of Computer Programs in info format
    phoenix-dark-mono-theme ;Monochromatic version of the Phoenix theme
    solarized-theme       ;The Solarized color theme
    nova-theme            ;A dark, pastel color theme
    kuronami-theme        ;A deep blue theme with cool autumnal colors
    j-mode                ;Major mode for editing J programs
    vterm                 ;Fully-featured terminal emulator
    multi-vterm           ;Like multi-term.el but for vterm
    meow                  ;modal editng with multi cursors and leader key support
    rg                    ;A search tool based on ripgrep
    i-ching               ;The Book of Changes
    ;picpocket             ;Image browser, with particular support for tag edit & filter
 ))

(defun my/packages-not-installed (pkgs)
  (seq-filter (lambda (x) (not (package-installed-p x))) pkgs))

(dolist (pkg (my/packages-not-installed (append my/packages
						my/packages-melpa)))
    (package-install pkg))


;;; for emacsclient
;;; alias em='emacsclient -t -a "emacs -Q -l ~/mg_init/init.el " '
(server-start)


(load-theme 'solarized-zenburn 1)

(setq gc-cons-threshold (* 2 1000 1000))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "c71fd8fbda070ff5462e052d8be87423e50d0f437fbc359a5c732f4a4c535c43" "9c72688b960c505a8495585ddd9a9764e991884ebf87c7fbedc3f31851d2add2" "77f1e155387d355fbbb3b382a28da41cc709b2a1cc71e7ede03ee5c1859468d2" "fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c" "524fa911b70d6b94d71585c9f0c5966fe85fb3a9ddd635362bfabd1a7981a307" "1a6d120936f9df3f44953124dbf9e56b399e021702ca7d1844e6c5e1658b692b" "02fefdfc9a0c7256a10c8794a4985c9c70c5fbf674873b66807e8143e02c81a7" "986cfa891116be38a60d1e82d820965249ea44e0d6348634a40ef6827f27bbb0" "90a6f96a4665a6a56e36dec873a15cbedf761c51ec08dd993d6604e32dd45940" "3d21eda97ce916fda054b0d2e1381e3fb3118cee79749e4b282b55fc461fb13e" "c335adbb7d7cb79bc34de77a16e12d28e6b927115b992bccc109fb752a365c72" default))
 '(package-selected-packages
   '(register-jump zoom wgrep-ag w3m vundo vlf vc-use-package undo-tree timu-spacegrey-theme tao-theme solarized-theme sml-mode sicp sexy-monochrome-theme rg quelpa-use-package qrencode pyim-basedict pyim phoenix-dark-mono-theme nova-theme nov nimbus-theme nano-theme multi-vterm monokai-theme meow material-theme magit lispy kuronami-theme i-ching howm evil dired-single deft darktooth-theme creamsody-theme counsel benchmark-init arduino-mode ample-theme ag afternoon-theme))
 '(package-vc-selected-packages
   '((register-jump :vc-backend Git :url "https://github.com/leoliu/register-jump.el"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diary ((t (:background "dark green" :foreground "#F0DFAF")))))
