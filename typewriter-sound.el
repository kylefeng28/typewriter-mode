;;; typewriter-sound.el --- Sounds

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

;;; Sound functions
(defun typewriter-play-sound (sound-file)
  "Play sound"
  (if typewriter-play-command
      (start-process-shell-command "typewriter-sound" nil
                                   (concat
                                    typewriter-play-command " "
                                    sound-file))
    (play-sound-file sound-file)))

;; Play default typing sound
(defun typewriter-play-default ()
  (typewriter-play-sound typewriter-sound-default))
;; End of line sound
(defun typewriter-play-end ()
  (typewriter-play-sound typewriter-sound-end))
;; Return sound
(defun typewriter-play-return ()
  (typewriter-play-sound typewriter-sound-return))
;; Spacebar sound
(defun typewriter-play-space ()
  (typewriter-play-sound typewriter-sound-space))
;; Backspace sound
(defun typewriter-play-backspace ()
  (typewriter-play-sound typewriter-sound-backspace))

(defun typewriter-play-sound-based-on-key ()
  (if typewriter-sound-mode
      (cond
       ;; End of line
       ((or (member (this-command-keys) typewriter-keys-end)
            (member this-command typewriter-funcs-end)
            (> (current-column) fill-column))
        (typewriter-play-end))

       ;; Return
       ((or (member (this-command-keys) typewriter-keys-return)
            (member this-command typewriter-funcs-return))
        (typewriter-play-return))
       
       ;; Space
       ((or (member (this-command-keys) typewriter-keys-space)
            (member this-command typewriter-funcs-space))
        (typewriter-play-space))

       ;; Backspace
       ((or (member (this-command-keys) typewriter-keys-backspace)
            (member this-command typewriter-funcs-backspace))
        (typewriter-play-backspace))

       ;; Default
       (t (typewriter-play-default))
   )))

;;; Sound minor mode
(defun typewriter-sound-on ()
  (setq-local typewriter-sound-mode t)
  (add-hook 'post-command-hook 'typewriter-play-sound-based-on-key nil t))

(defun typewriter-sound-off ()
  (setq-local typewriter-sound-mode nil)
  (remove-hook 'post-command-hook 'typewriter-play-sound-based-on-key t))

(define-minor-mode typewriter-sound-mode
  "Toggle typewriter sound."
  nil
  " Typewriter-sound"
  ;; keymap
  nil
  :global nil
  (if typewriter-sound-mode
      (typewriter-sound-on)
    (typewriter-sound-off)))

(provide 'typewriter-sound)
;;; typewriter-sound.el ends here
