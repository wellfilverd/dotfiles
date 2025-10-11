;; Setup Packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; Custom Functions

;;https://stackoverflow.com/questions/88399/how-do-i-duplicate-a-whole-line-in-emacs
(defun jr-duplicate-line ()
  "EASY"
  (interactive)
  (save-excursion
    (let ((line-text (buffer-substring-no-properties
                      (line-beginning-position)
                      (line-end-position))))
      (move-end-of-line 1)
      (newline)
      (insert line-text))))
;;https://stackoverflow.com/questions/3417438/close-all-buffers-besides-the-current-one-in-emacs
(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer 
        (delq (current-buffer) 
              (cl-remove-if-not 'buffer-file-name (buffer-list)))))

;;https://stackoverflow.com/questions/20514360/opening-a-window-into-a-specified-buffer
(defun open-dir-at-right ()
  (interactive)         ;; Tell emacs this function can be called interactively
  (split-window-right)  ;; Just what C-x 3 does
  (dired "~/dev/datomic"))              ;; Just what M-x dired does

(defun reload-conf ()
  (interactive)
  (load-file "~/.emacs"))

(defun start-clojure-repl ()
  (interactive)
  (inf-clojure "~/dev/datomic/git/datomic-enterprise/bin/repl"))

(defun my-magit-blame ()
  (interactive)
  ;; TODO: implement
  )

;; Custom keybinding

;; duplicate line
(global-set-key "\C-cd" 'jr-duplicate-line)
;; kill other buffers
(global-set-key "\C-cK" 'kill-other-buffers)
;; fill region
(global-set-key "\C-c=" 'fill-region)
;; open current dirin right buffer
(global-set-key "\C-c3" 'open-dir-at-right)
;; reload emacs conf
(global-set-key (kbd "C-c R") 'reload-conf)
;; start clojure repl
(global-set-key (kbd "C-c rr") 'start-clojure-repl)
;; magit blame
(global-set-key (kbd "C-c mb") 'my-magit-blame)


;; Backup files
(setq backup-directory-alist `(("." . "~/.saves")))

;; Hooks
;;(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
(add-hook 'clojure-mode-hook          #'enable-paredit-mode)

;; cider, inf-clojure
(add-hook 'clojure-mode-hook          #'inf-clojure-minor-mode)
;; (add-hook 'clojure-mode-hook #'cider-mode)

;; dumb jump
(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)

;; repl
(add-to-list 'auto-mode-alist '("\\.repl\\'" . clojure-mode))

;; abbrevs
(add-hook 'clojure-mode-hook #'abbrev-mode)

;; alter key-bindings in paredit
(eval-after-load "paredit"
  '(progn
     (define-key paredit-mode-map (kbd "M-s") 'nil))) ;; default paredit-splice-sexp

;; Globals
(global-display-line-numbers-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(global-display-line-numbers-mode t)
 '(inhibit-startup-buffer-menu nil)
 '(inhibit-startup-screen t)
 '(package-selected-packages '(dumb-jump cider inf-clojure clojure-mode magit paredit))
 '(ring-bell-function 'ignore)
 '(tab-bar-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Menlo" :foundry "nil" :slant normal :weight regular :height 130 :width normal))))
 '(tool-bar ((t (:foreground "black" :box (:line-width (1 . 1) :style released-button))))))
(put 'erase-buffer 'disabled nil)
