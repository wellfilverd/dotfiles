;; UI
(set-face-attribute 'default (selected-frame) :height 160)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode)

;; Install Packages
(require 'package)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))
(package-initialize nil)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package paredit
  :delight " (p)"
  :hook ((lisp-mode emacs-lisp-mode) . paredit-mode)
  :config
  (defun check-region-parens ()
    "check if parentheses in the region are balanced. signals a
scan-error if not."
    (interactive)
    (save-restriction
      (save-excursion
        (let ((deactivate-mark nil))
          (condition-case c
              (progn
                (narrow-to-region (region-beginning) (region-end))
                (goto-char (point-min))
                (while (/= 0 (- (point)
                                (forward-list))))
                t)
            (scan-error (signal 'scan-error '("region parentheses not balanced")))))))))

(use-package clojure-mode
  :ensure t)
(add-to-list 'auto-mode-alist '("\\.repl" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.repl\\'" . clojure-mode))
(add-hook 'clojure-mode-hook #'paredit-mode)
(add-hook 'clojure-mode-hook #'subword-mode)
(add-hook 'clojure-mode-hook #'eldoc-mode)

;; Load Packages
(require 'paredit)
(require 'clojure-mode)

;; Import system env, like PATH
(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :config
  (exec-path-from-shell-initialize))

(eval-after-load 'paredit
  '(progn
     (define-key paredit-mode-map (kbd "M-q") 'paredit-reindent-defun)
     (define-key paredit-mode-map (kbd "C-<left>") 'paredit-forward-barf-sexp)
     (define-key paredit-mode-map (kbd "C-M-<right>") 'paredit-backward-barf-sexp)
     (define-key paredit-mode-map (kbd "C-<right>") 'paredit-forward-slurp-sexp)
     (define-key paredit-mode-map (kbd "C-M-<left>") 'paredit-backward-slurp-sexp)
     (define-key paredit-mode-map (kbd "M-S-s") 'paredit-split-sexp)
     (define-key paredit-mode-map (kbd "M-s") 'paredit-splice-sexp)
     (define-key paredit-mode-map (kbd "C-k") 'paredit-kill)
     (define-key paredit-mode-map (kbd "M-[") 'paredit-wrap-square)
     (define-key paredit-mode-map (kbd "M-{") 'paredit-wrap-curly)
     (define-key paredit-mode-map (kbd "M-(") 'paredit-wrap-round)
     (define-key paredit-mode-map (kbd "M-<right>") 'forward-sexp)
     (define-key paredit-mode-map (kbd "M-<left>") 'backward-sexp)
     (define-key paredit-mode-map (kbd "M-<up>") 'backward-up-list)
     (define-key paredit-mode-map (kbd "M-<down>") 'down-list)
     (define-key paredit-mode-map (kbd "<A-return>") 'paredit-newline)))
(eval-after-load 'clojure-mode
  '(progn
     ;; (define-key paredit-mode-map (kbd "C-z") 'run-clojure-no-prompt)
     (define-key paredit-mode-map (kbd "C-c C-z") 'run-clojure)
     (define-key paredit-mode-map (kbd "C-M-x") 'clj-eval-defun) ;; primary eval command
     (define-key paredit-mode-map (kbd "C-c C-e") 'clj-eval-defun)
     (define-key paredit-mode-map (kbd "C-x C-e") 'lisp-eval-last-sexp)
     (define-key paredit-mode-map (kbd "C-c C-l") 'clj-load-file)
     (define-key paredit-mode-map (kbd "C-c C-b") 'clj-load-buffer)
     (define-key paredit-mode-map (kbd "C-c C-n") 'lisp-eval-form-and-next)
     (define-key paredit-mode-map (kbd "C-c C-p") 'lisp-eval-paragraph)
     ;; (define-key paredit-mode-map (kbd "C-c C-r") 'lisp-eval-region)
     (define-key paredit-mode-map (kbd "C-M-q") 'indent-sexp)
     (define-key paredit-mode-map (kbd "C-c C-v") 'lisp-show-variable-documentation)
     (define-key paredit-mode-map (kbd "C-c C-f") 'lisp-show-function-documentation)
     (define-key paredit-mode-map (kbd "C-c C-a") 'lisp-show-arglist)
     (define-key paredit-mode-map (kbd "C-c C-c") 'clj-eval-defun) ;; not working currently
     (define-key paredit-mode-map (kbd "C-c C-k") 'lisp-compile-file) ;; not working currently
     (define-key paredit-mode-map (kbd "C-c C-i") 'lisp-compile-file)
     ))
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'lisp-mode-hook              #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook  #'enable-paredit-mode)
(add-hook 'clojure-mode-hook           #'enable-paredit-mode)
(setq lisp-function-doc-command
      "(clojure.repl/doc %s)\n")
(setq lisp-var-doc-command
      "(clojure.repl/doc %s)\n")
(setq lisp-var-doc-command
      "(clojure.repl/doc %s)\n")
(setq rebl-inspect-command
      "(try
          (let [inspect (requiring-resolve 'cognitect.rebl/inspect)]
               (inspect %s)
               (catch Exception e
                      nil)))\n")
(setq lisp-arglist-command
      "(str \"%1$s args: \"
            (or (some-> '%1$s resolve meta :arglists)
                \"Not Found\"))\n")

;; Clojure Inferior Lisp
(setq inferior-lisp-program "clojure")
(setq clojure-build-tool-files '("deps.edn"))
(defvar clj-repl-command)
(defvar clj-repl-command-history '())

;;cli
(defun run-clojure (cmd)
  (interactive (list
                (if (boundp 'clj-repl-command)
                    (let ((first-command (car clj-repl-command))
                          (rest-commands (if clj-repl-command-history
                                             (append (cdr clj-repl-command) clj-repl-command-history)
                                           (cdr clj-repl-command))))
                      (read-from-minibuffer "Command:" first-command nil nil 'rest-commands))
                  (read-from-minibuffer "Command:" "clojure" nil nil 'clj-repl-command-history))))
  (run-clojure-command cmd))

;;run main
(defun run-clojure-command (cmd)
  (let* ((cb (current-buffer))
	 (default-directory (clojure-project-root-path)))

    (run-lisp cmd)
    (switch-to-buffer cb)
    (switch-to-buffer-other-window "*inferior-lisp*")))

;; Remove this line to disable warnings about unsafe variables when using .dir-locals with 'run-command
;; Only use this if you are certain of the integrity of .dir-locals files upstream of where you launch your REPL
(put 'clj-repl-command 'safe-local-variable (lambda (_) t))
;; regex, not plain string
;; TODO allow define in dir-local
(defconst ignored-forms '("comment"))
(defun check-ignored-forms (forms)
  (interactive "P")
  (let ((ret nil))
    (dolist (form ignored-forms)
      (when (looking-at (concat "(" form))
        (setq ret 't)))
    ret))
(defun clj-do-defun (do-region)
  "Send the current defun to the inferior Lisp process.
The actually processing is done by `do-region'. Ignores (comment) forms."
  (save-excursion
    ;; if there's a form after the cursor, jump into it before parsing.
    ;; lisp-eval-defun doesn't do this. Unsure if we should?
    ;;(when (looking-at "(")
    ;;  (down-list))
    (let ((err nil)
          (forms '()))
      ;; build a list of sexp start locations before the cursor position
      ;; error on top-level form and continue
      (while (not (eq err 1))
        (condition-case nil
            (backward-up-list nil t)
          (error (setq err 1)))
        (add-to-list 'forms (point)))
      ;; We're at the top-level defun now, check for comment
      ;; This could check against a list of forms to ignore and
      ;; climb up to the first not-ignored form
      (if (check-ignored-forms ignored-forms) ;;(looking-at "(comment")
          (if (or (eq 1 (length forms)) (null forms))
              (message "No top level form, or top level form ignored.")
            (progn
              (goto-char (cadr forms))
              (forward-sexp)
              (funcall do-region (cadr forms) (point))))
        (progn
         (let ((start (point)))
           (forward-sexp)
           (funcall do-region start (point))))))))
(defun clj-eval-defun (&optional and-go)
  "Send the current defun to the inferior Lisp process, assuming a Clojure REPL."
  (interactive "P")
  (clj-do-defun 'lisp-eval-region)
  (if and-go (switch-to-lisp t)))
(defvar clj-load-file-history '())
(defun clj-load-file (file-name)
  "Send (load-file) to the inferor-lisp process with an argument
of the file associated with the current buffer. Supports history."
  (interactive (list
                (read-from-minibuffer "File Path:" (buffer-file-name) nil nil 'clj-load-file-history)))
  (let ((proc (inferior-lisp-proc))
         (load-string (format "(load-file \"%s\")\n" file-name)))
    (comint-check-source file-name)
    (comint-send-string proc load-string)))
(defun clj-load-buffer ()
  "Start at top of buffer, eval each form in the inferior-lisp buffer until reaching end of file.
This strategy avoids a comint string-length limit on macOS that exists at time of writing."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (< (point) (point-max))
      (lisp-eval-form-and-next))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(clojure-mode paredit exec-path-from-shell))
 '(safe-local-variable-values
   '((clj-environment "AWS_PROFILE=bubbagumpshrimp" "AWS_REGION=us-east-1" "MY_TEST_VAR=1"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
