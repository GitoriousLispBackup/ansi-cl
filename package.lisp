;;; define the example source code's package.
(if (null (find-package :ansi-cl))
    (progn
      (format t "[+] creating :ansi-cl package.")
      (defpackage :ansi-cl
        (:use :common-lisp))))
