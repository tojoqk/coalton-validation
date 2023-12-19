(defsystem #:tokyo.tojo.validation
  :description "Validation library for Coalton"
  :author "Masaya Tojo"
  :license  "MIT"
  :version "0.0.0"
  :depends-on (#:coalton)
  :serial t
  :pathname "src/"
  :components ((:file "applicative")
               (:file "validation"))
  :in-order-to ((test-op (test-op "tokyo.tojo.validation/test"))))

(defsystem #:tokyo.tojo.validation/test
  :description "Tests for tokyo.tojo.validation"
  :author "Masaya Tojo"
  :license  "MIT"
  :version "0.0.0"
  :depends-on (#:tokyo.tojo.validation #:coalton/testing #:fiasco)
  :perform (test-op (o s)
                    (symbol-call '#:tokyo.tojo.validation/test '#:run-tests))
  :serial t
  :pathname "test/"
  :components ((:file "test")
               (:file "applicative")
               (:file "validation")))
