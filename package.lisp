;;; define the example source code's package.
(if (null (find-package :ansi-cl))
    (defpackage :ansi-cl
      (:use :common-lisp)))
