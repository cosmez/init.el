;;Package Management
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))


(package-initialize)

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.  Return a list of installed packages or nil for every skipped package."
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
 'color-theme-modern
 'racket-mode
 'company
 'multiple-cursors
 'flycheck
 'visual-regexp
 'visual-regexp-steroids
 'cider
 'projectile
 'smex ;Smex is a M-x enhancement for Emacs
 'idle-highlight-mode ;for seeing everywhere else an identifier is used at a glance
 'find-file-in-project ;find-file in project C-c f
 'color-theme-sanityinc-tomorrow
 'sly
 )


(require 'visual-regexp-steroids)
(require 'multiple-cursors)
(require 'ido)
(require 'smex) ;;Smex is a M-x enhancement for Emacs
(require 'flycheck)
(require 'company)
(require 'multiple-cursors)
(require 'racket-mode)
(require 'sly-autoloads)



(setq inferior-lisp-program "C:/SBCL/sbcl.exe")



(ido-mode 1)
(ido-everywhere 1)
(smex-initialize)


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
(add-hook 'racket-mode-hook 'lisp-hook)
(add-hook 'emacs-lisp-mode-hook 'lisp-hook)
(add-to-list 'auto-mode-alist '("\\.rkt\\'" . racket-mode))


;;LOOKS AND BASIC BEHAVIO
(setq make-backup-files nil)
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
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

(global-hl-line-mode 0)

(load-theme 'sanityinc-tomorrow-night)


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
 '(custom-safe-themes
   '("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default))
 '(package-selected-packages
   '(sly color-theme-sanityinc-tomorrow find-file-in-project idle-highlight-mode smex color-theme-modern ido-ubiquitous projectile cider visual-regexp-steroids visual-regexp flycheck multiple-cursors company racket-mode color-theme rainbow-delimiters paredit magit))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight normal :height 98 :width normal)))))


(cd "F:\\home")

(provide '.emacs)
;;; .emacs ends here
