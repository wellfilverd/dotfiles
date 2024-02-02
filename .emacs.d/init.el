;; UI
(set-face-attribute 'default (selected-frame) :height 160)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode)

;; Packages
;; first, declare repositories
(setq package-archives              
      '(("gnu" . "https://elpa.gnu.org/packages/")
	("melpa" . "https://melpa.org/packages/"))) 

;; Init the package facility
(require 'package)
(package-initialize)

