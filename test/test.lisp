(defpackage #:coalton-validation/test
  (:use #:coalton
        #:coalton-prelude
        #:coalton-testing)
  (:local-nicknames
   (#:ap #:coalton-validation/applicative)
   (#:validation #:coalton-validation/validation))
  (:export #:run-tests))

(in-package #:coalton-validation/test)

(named-readtables:in-readtable coalton:coalton)

(fiasco:define-test-package #:applicative-validation/fiasco-test-package)

(coalton-fiasco-init #:applicative-validation/fiasco-test-package)

(cl:defun run-tests ()
  (fiasco:run-package-tests
   :packages '(#:applicative-validation/fiasco-test-package)
   :interactive cl:t))
