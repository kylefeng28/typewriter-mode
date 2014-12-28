;;; typewriter-edit.el --- Typewriter editing

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

;;; Typewriter editing functions
(defun typewriter-insert (fun &rest args)
  (if (not typewriter-edit-mode) ;; Typewriter editing is off
      (apply fun args) ;; self-insert-command
    (progn
      (scroll-left 1)
      (if (or (not typewriter-restrict-editing) ;; Restricted editing is off
              (eq (following-char) 10) ;; Newline
              (eq (following-char) 0)) ;; End of buffer
          (apply fun args) ;; self-insert-command
        (forward-char)
        (insert-char
         (cdr (assoc (this-command-keys)
                     typewriter-keys-replace-alist)))))))

(defun typewriter-delete (fun &rest args)
  (if (not typewriter-edit-mode) ;; Typewriter editing is off
      (apply fun args) ;; Delete (depends on what fun is)
    (progn 
      (scroll-right 1)
      (if (not typewriter-restrict-editing) ;; Restricted editing is off
          (apply fun args) ;; Delete (depends on what fun is)
        (backward-char)))))

(defun typewriter-delete-interactive (arg)
  (interactive "*p")
  (typewriter-delete 'backward-delete-char arg))

;;; Typewriter editing minor mode
(defun typewriter-edit-on ()
  (setq-local typewriter-edit-mode t)
;TODO: fix this hack
  (advice-add 'self-insert-command :around 'typewriter-insert)
  (advice-add 'backward-delete-char :around 'typewriter-delete)
  (advice-add 'backward-delete-char-untabify :around 'typewriter-delete)
  (advice-add 'evil-delete-backward-char :around 'typewriter-delete)
  (advice-add 'evil-delete-backward-char-and-join :around 'typewriter-delete)
  )

(defun typewriter-edit-off ()
  (setq-local typewriter-edit-mode nil)
  (advice-remove 'self-insert-command 'typewriter-insert)
  (advice-remove 'backward-delete-char-untabify 'typewriter-delete))

(define-minor-mode typewriter-edit-mode
  "Toggle typewriter-style editing."
  nil
  " Typewriter-edit"
  ;; keymap
  nil
  :global nil
  (if typewriter-edit-mode
      (typewriter-edit-on)
    (typewriter-edit-off)))

(provide 'typewriter-edit)
;;; typewriter-edit.el ends here
