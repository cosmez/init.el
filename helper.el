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
