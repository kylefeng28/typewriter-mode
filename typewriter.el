;;; typewriter.el --- Typewriter simulator for Emacs

;; Copyright (C) 2013-2014 Kyle Feng,
;;               2013 Peter Vasil

;; Authors: Kyle Feng <kylefeng28@gmail.com>, Peter Vasil <mail@petervasil.net>
;; Created 24 Dec 2014
;; Version: 1.0.0
;; Keywords: typewriter
;; URL: https://github.com/AeroFengBlade/typewriter-mode

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Minor mode for simulating a typewriter.
;; Forked from Peter Vasil's typewriter-mode
;;   <https://github.com/ptrv/emacs.d/blob/master/site-lisp/misc/typewriter-mode.el>.
;; Inspired by Bob Newell's writer-mode <http://www.bobnewell.net/writer-typewriter.el>.
;; See README.

;;; Code:

(require 'typewriter-common)
(require 'typewriter-sound)
(require 'typewriter-edit)

;; Typewriter minor mode
(defun typewriter-mode-on ()
  (setq typewriter-mode t)
  (typewriter-sound-mode t)
  (typewriter-edit-mode t))

(defun typewriter-mode-off ()
  (setq typewriter-mode nil)
  (typewriter-sound-mode 0)
  (typewriter-edit-mode 0))

(define-minor-mode typewriter-mode
  "Toggle typewriter mode."
  nil
  " Typewriter"
  ;; keymap
  nil
  :global nil
  (if typewriter-mode
      (typewriter-mode-on)
    (typewriter-mode-off)))

;; Evil state
(evil-define-state typewriter
  "Typewriter state."
  :tag " <T> "
  :message "-- TYPEWRITER --"
  :enable (insert)
  :cursor (box)
  (if (evil-typewriter-state-p)
      (typewriter-mode t)
    (typewriter-mode 0)))

(define-key evil-typewriter-state-map (kbd "DEL") 'typewriter-delete-interactive)

;; Keybindings
(evil-leader/set-key "tt" 'evil-typewriter-state)

(provide 'typewriter)
;;; typewriter.el ends here
