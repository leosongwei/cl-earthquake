;;;;CL-EARTHQUAKE
;; Compile(With SBCL):
;; (save-lisp-and-die "cl-earthquake-xml" :executable t :toplevel #'main)
(ql:quickload "drakma")
(ql:quickload "s-xml")

;;;; {{{{
(defparameter *emsc-xml* "http://www.emsc-csem.org/service/rss/rss.php?typ=emsc")
(defparameter *working-directory* "/home/leo/dev/sh/cl-earthquake")

(defun get-earthquake-info (url)
  (subseq (cadr
            (s-xml:parse-xml-string
              (drakma:http-request url)))
          8))

(defun search-indicator (indicator lst)
  (let ((result nil))
    (dolist (element lst result)
      (if (eql (car (if (listp element) element nil))
               indicator)
        (setf result element)))))

(defun get-emsc-time (earthquake)
  (cadr (search-indicator
          :|comments| earthquake)))

(defun exec-notify (earthquake)
  (let ((title (cadr (search-indicator
                       :|title| earthquake)))
        (date (cadr (search-indicator
                      :|comments| earthquake))))
    (asdf:run-shell-command
      (format nil "notify-send '~A Date:~A'"
              title date))))

(defun write-printed (string)
  (with-open-file (str
                    (make-pathname
                      :name ".printed")
                    :direction :output
                    :if-exists :supersede)
    (format str "~A~%" string)))

(defun read-printed ()
  (with-open-file (str
                    (make-pathname
                      :name ".printed")
                    :direction :input)
    (read-line str nil 'eof)))

(defun check-if-new-and-notify (earthquake)
  (format t "checking~~~^_^~%")
  (if (string=
        (concatenate 'string
                     (get-emsc-time earthquake))
        (if (probe-file ".printed")
          (read-printed)
          "no"))
    (format t "already printed -_-~%")
    (progn (exec-notify earthquake)
           (write-printed
             (concatenate 'string
                          (get-emsc-time earthquake))))))
;;;; }}}}

(defun main ()
  (tagbody
    :a
    (handler-case
      (check-if-new-and-notify
        (car
          (get-earthquake-info *emsc-xml*)))
      (type-error () "type error, may be a 404")
      (usocket:ns-host-not-found-error () "network problem")
      (condition () "unexpected problem"))
    (sleep 180)
    (go :a)))


