(defun kibo:select-current-line ()
  "Select the current line"
  (interactive)
  (end-of-line) ; move to end of line
  (set-mark (line-beginning-position)))

(defun kibo:replace-lines (template)
  "Replace every line with the template"
  (interactive "s")
  (goto-char 0)
  (while (re-search-forward "..*" nil t)
    (goto-char (match-beginning 0))
    (when (looking-at "..*")
      (replace-match (replace-regexp-in-string "$1" (match-string 0) template)))
    (forward-line)))




(defun kibo:eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))





(global-set-key (kbd "<C-f5>") 'kibo:eval-and-replace)


(defun toggle-window-dedicated ()
  "Control whether or not Emacs is allowed to display another
buffer in current window."
  (interactive)
  (message
   (if (let (window (get-buffer-window (current-buffer)))
         (set-window-dedicated-p window (not (window-dedicated-p window))))
       "%s: Can't touch this!"
     "%s is up for grabs.")
   (current-buffer)))

(global-set-key (kbd "C-c t") 'toggle-window-dedicated)
