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


(ensure-package-installed 'magit 'paredit 'rainbow-delimiters 'geiser 'color-theme 'solarized-theme 'tango-2-theme 'leuven-theme 'racket-mode 'company 'multiple-cursors)
 
(require 'multiple-cursors)
(require 'ido)
(ido-mode t)



;; Scheme hooks
(add-hook 
 'scheme-mode-hook 
 'enable-paredit-mode
 'rainbow-delimiters-mode-enable)

;; Racket mode configuration
(add-hook
 'racket-mode-hok
 'enable-paredit-mode
 'rainbow-delimiters-mode
 'company-mode)

(add-to-list 'auto-mode-alist '("\\.rkt\\'" . racket-mode))


;;basic looks
(blink-cursor-mode 1)
(line-number-mode t)
(column-number-mode t)
(tool-bar-mode 0)
;;; Always do syntax highlighting
(setq font-lock-maximum-decoration t)
(global-font-lock-mode 1)
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
;; Basic Behavior -> enter to indent
(define-key global-map (kbd "RET") 'newline-and-indent)
;; Use Chicken Scheme by default

(global-hl-line-mode 0)
;; Geiser Configuration
(setq geiser-impl-installed-implementations '(racket guile))
(setq geiser-default-implementation 'racket)
(add-hook 
 'scheme-mode-hook 
 'enable-geiser-mode) 
;; in order for geiser to recognize the current namespace
;; first save the file and press C-u C-c C-z 



;; load the desired theme
(load-theme 'wombat t)

;; dont create backup files
(setq make-backup-files nil)

(require 'multiple-cursors)
(global-set-key (kbd "C-*") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-+") 'mc/mark-all-like-this)


(load "~/.emacs.d/helper.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" "21d9280256d9d3cf79cbcf62c3e7f3f243209e6251b215aede5026e0c5ad853f" default)))
 '(font-use-system-font t)
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight normal :height 113 :width normal)))))
