#!/usr/bin/env -S sbcl --script

(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))

(defvar *text*
  "spam")

(defun main ()
  (let ((counter 0))
    (loop
      (format t "~d spaming...~%" counter)
      (force-output)
      (uiop:run-program (format nil "xdotool type ~a" *text*))
      (sleep 1)
      (uiop:run-program "xdotool key BackSpace BackSpace BackSpace BackSpace")
      (setf counter (1+ counter)))))

(handler-case
    (main)
  (sb-sys:interactive-interrupt () (progn
                                     (format *error-output* "~%Abort.~&")
                                     (sb-ext:exit))))
