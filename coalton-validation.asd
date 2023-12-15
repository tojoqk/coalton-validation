(defsystem #:coalton-validation
  :description "Validation library for Coalton"
  :author "Masaya Tojo"
  :license  "MIT"
  :version "0.0.0"
  :depends-on (#:coalton)
  :serial t
  :pathname "src/"
  :components ((:file "applicative")
               (:file "validation"))
  :in-order-to ((test-op (test-op "coalton-validation/test"))))

(defsystem #:coalton-validation/test
  :description "Tests for coalton-validation"
  :author "Masaya Tojo"
  :license  "MIT"
  :version "0.0.0"
  :depends-on (#:coalton-validation #:coalton/testing #:fiasco)
  :perform (test-op (o s)
                    (symbol-call '#:coalton-validation/test '#:run-tests))
  :serial t
  :pathname "test/"
  :components ((:file "test")
               (:file "applicative")
               (:file "validation")))
