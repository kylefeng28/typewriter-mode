;;; typewriter-common.el --- Common functions and utilities

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

;; Strikethrough face
(defface strikethrough
  '((t :strike-through t))
  "Basic strikethrough face."
  :group 'basic-faces)

;;; Options
;; Group
(defgroup typewriter nil
  "Typewriter simulator for Emacs."
  :group 'emulations
  :prefix 'typewriter-)

;; Sound options
(defcustom typewriter-play-sounds t
  "Whether to play keypress sounds."
  :group 'typewriter)

;; Typewriter editing options
(defcustom typewriter-restrict-editing t
  "Whether to restrict editing to append-only."
  :group 'typewriter)

;;; Variables
;; Sound variables
(defcustom typewriter-sound-directory
  (file-name-as-directory
   (concat (file-name-directory load-file-name) "sounds"))
  "Typing sound file directory"
  :group 'typewriter)

(defcustom typewriter-sound-default
  (concat typewriter-sound-directory "default.mp3")
  "Typing sound file path"
  :group 'typewriter)

(defcustom typewriter-sound-end
  (concat typewriter-sound-directory "bell.mp3")
  "End of line sound file path"
  :group 'typewriter)

(defcustom typewriter-sound-return
  (concat typewriter-sound-directory "return.mp3")
  "Carriage return sound file path"
  :group 'typewriter)

(defcustom typewriter-sound-space
  (concat typewriter-sound-directory "space.mp3")
  "Spacebar sound file path"
  :group 'typewriter)

(defcustom typewriter-sound-backspace
  (concat typewriter-sound-directory "backspace.mp3")
  "Backspace sound file path"
  :group 'typewriter)

(defcustom typewriter-play-command "afplay"
  "Sound player command"
  :group 'typewriter)

;; Typewriter editing options
(defcustom typewriter-restrict-editing t
  "Whether to restrict editing to append-only."
  :group 'typewriter)


;;; Triggers
;; Key triggers
(defcustom typewriter-keys-end (list )
  "End of line sound key triggers")
(defcustom typewriter-keys-return (list (kbd "RET"))
  "Carriage return sound key triggers")
(defcustom typewriter-keys-space (list (kbd "SPC"))
  "Spacebar sound key triggers")
(defcustom typewriter-keys-backspace (list (kbd "DEL"))
  "Backspace sound key triggers")

;; Function triggers
(defcustom typewriter-funcs-end '(end-of-line
                                  evil-end-of-line)
  "End of line sound function triggers"
  :group 'typewriter)

(defcustom typewriter-funcs-return '(newline-and-indent
                                     evil-open-below
                                     next-line)
  "Carriage return sound function triggers"
  :group 'typewriter)

(defcustom typewriter-funcs-space '(forward-char
                                    evil-forward-char)
  "Spacebar sound function triggers"
  :group 'typewriter)

(defcustom typewriter-funcs-backspace '(delete-backward-char
                                        evil-delete-backward-char
                                        backward-char
                                        evil-backward-char
                                        previous-line)
  "Backspace sound function triggers"
  :group 'typewriter)

(defcustom typewriter-keys-replace-alist
  (list
      (cons (kbd "-") #x0336) ; Strikethrough
      (cons (kbd "`") #x0300) ; Grave
      (cons (kbd "'") #x0301) ; Acute
      (cons (kbd "^") #x0302) ; Circumflex ("hat")
      (cons (kbd "~") #x0303) ; Tilde
      )
  "Keys to replace."
  :group 'typewriter)

(provide 'typewriter-common)
;;; typewriter-common.el ends here
