(require 'package)

;; marmalade basic configuration
(add-to-list 'package-archives 
	     '("marmalade" .
	       "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives 
	     '("melpa" .
	       "http://melpa.milkbox.net/packages/"))

(package-initialize)

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.
   Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     ;; (package-installed-p 'evil)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))


;; make sure to have downloaded archive description.
;; Or use package-archive-contents as suggested by Nicolas Dudebout
(or (file-exists-p package-user-dir)
    (package-refresh-contents))



(ensure-package-installed
 'magit ; git without being driven insane.
 'paredit ;keeps parentheses under control
 'rainbow-delimiters
 'color-theme
 'racket-mode
 'company
 'multiple-cursors
 'flycheck
 'visual-regexp
 'visual-regexp-steroids
 'cider
 'projectile
 'ido-ubiquitous ;for geting ido goodness everywhere else.
 'smex ;Smex is a M-x enhancement for Emacs
 'idle-highlight-mode ;for seeing everywhere else an identifier is used at a glance
 'find-file-in-project ;find-file in project C-c f
 'color-theme-sanityinc-tomorrow
 )


(require 'visual-regexp-steroids)
(require 'multiple-cursors)
(require 'ido)
(require 'smex) ;;Smex is a M-x enhancement for Emacs
(require 'ido-ubiquitous)
(require 'flycheck)
(require 'company)
(require 'multiple-cursors)
(require 'racket-mode)


(ido-mode 1)
(ido-everywhere 1)
(smex-initialize)
(ido-ubiquitous-mode 1)



;;ido configuration
(setq
 ido-ignore-buffers '("^ " "*Completions*" "*Shell Command Output*"
		      "*Messages*" "Async Shell Command"))

;;idle highlight

(defun lisp-hook ()
  (make-local-variable 'column-number-mode)
  (column-number-mode t)
  (if window-system (hl-line-mode t))
  (idle-highlight-mode t)
  (enable-paredit-mode)
  (company-mode t)
  (rainbow-delimiters-mode-enable))

;; FlyCheck Mode
(add-hook 'after-init-hook #'global-flycheck-mode)


;; Mode Hooks
(add-hook 'racket-mode-hook'lisp-hook)
(add-hook 'emacs-lisp-mode-hook 'lisp-hook)

(add-to-list 'auto-mode-alist '("\\.rkt\\'" . racket-mode))


;;LOOKS AND BASIC BEHAVIOR
(blink-cursor-mode 1)
(line-number-mode t)
(column-number-mode t) 
(tool-bar-mode 0) ; hide the toolbar
(setq tab-always-indent 'complete)
;;; Always do syntax highlighting
(setq font-lock-maximum-decoration t)
(global-font-lock-mode 1)
;(set-face-attribute hl-line-face nil :underline nil)
;(set-face-background hl-line-face "gray13" )
;;; Also highlight parens
(setq show-paren-delay 0
      show-paren-style 'parenthesis)
(show-paren-mode 1)
(rainbow-delimiters-mode 1)
;; smooth scrolling
(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)


(global-hl-line-mode 0)

;; load the desired theme

;;(load-theme 'wombat t)
(load-theme 'sanityinc-tomorrow-night)

;; dont create backup files
(setq make-backup-files nil)




;;; GLOBAL KEYBINDINGS
(global-set-key (kbd "C-*") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-+") 'mc/mark-all-like-this)
(define-key global-map (kbd "C-c r") 'vr/replace)
(define-key global-map (kbd "C-c q") 'vr/query-replace)
;; if you use multiple-cursors, this is for you:
(define-key global-map (kbd "C-c m") 'vr/mc-mark)
;; to use visual-regexp-steroids's isearch instead of the built-in regexp isearch, also include the following lines:
(define-key esc-map (kbd "C-r") 'vr/isearch-backward) ;; C-M-r
(define-key esc-map (kbd "C-s") 'vr/isearch-forward) ;; C-M-s
;;smex configuration
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
;;find-file-in-project
(global-set-key (kbd "C-x f") 'find-file-in-project)
;;enter is newline and indent
(define-key global-map (kbd "RET") 'newline-and-indent)
(global-set-key [f7] (lambda () (interactive) (find-file user-init-file)))


;;; HELPER FUNCTIONS
(load "~/.emacs.d/helper.el")



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#ffffff" "#ff9da4" "#d1f1a9" "#ffeead" "#bbdaff" "#ebbbff" "#99ffff" "#002451"))
 '(column-number-mode t)
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes
   (quote
    ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "a041a61c0387c57bb65150f002862ebcfe41135a3e3425268de24200b82d6ec9" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "d46b5a32439b319eb390f29ae1810d327a2b4ccb348f2018b94ff22f410cb5c4" "bad832ac33fcbce342b4d69431e7393701f0823a3820f6030ccc361edd2a4be4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" "21d9280256d9d3cf79cbcf62c3e7f3f243209e6251b215aede5026e0c5ad853f" default)))
 '(fci-rule-color "#003f8e")
 '(font-use-system-font t)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#fdf6e3" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#586e75")
 '(highlight-tail-colors
   (quote
    (("#eee8d5" . 0)
     ("#B4C342" . 20)
     ("#69CABF" . 30)
     ("#69B7F0" . 50)
     ("#DEB542" . 60)
     ("#F2804F" . 70)
     ("#F771AC" . 85)
     ("#eee8d5" . 100))))
 '(hl-bg-color
   (quote
    ("#DEB542" "#F2804F" "#FF6E64" "#F771AC" "#9EA0E5" "#69B7F0" "#69CABF" "#B4C342")))
 '(hl-fg-colors
   (quote
    ("#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3")))
 '(magit-diff-use-overlays nil)
 '(package-selected-packages
   (quote
    (color-theme-sanityinc-tomorrow find-file-in-project idle-highlight-mode smex ido-ubiquitous projectile cider visual-regexp-steroids visual-regexp flycheck multiple-cursors company racket-mode color-theme rainbow-delimiters paredit magit)))
 '(pos-tip-background-color "#eee8d5")
 '(pos-tip-foreground-color "#586e75")
 '(save-place t nil (saveplace))
 '(show-paren-mode t)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#ff9da4")
     (40 . "#ffc58f")
     (60 . "#ffeead")
     (80 . "#d1f1a9")
     (100 . "#99ffff")
     (120 . "#bbdaff")
     (140 . "#ebbbff")
     (160 . "#ff9da4")
     (180 . "#ffc58f")
     (200 . "#ffeead")
     (220 . "#d1f1a9")
     (240 . "#99ffff")
     (260 . "#bbdaff")
     (280 . "#ebbbff")
     (300 . "#ff9da4")
     (320 . "#ffc58f")
     (340 . "#ffeead")
     (360 . "#d1f1a9"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#fdf6e3" "#eee8d5" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#657b83" "#839496"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight normal :height 113 :width normal)))))




(cd "C:\\home\\src")


(provide 'init)
;;; init.el ends here
