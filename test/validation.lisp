(in-package #:tokyo.tojo.validation/test)

(define-test validation-ok-test ()
  (matches (validation:Ok 3)
      (the (validation:Validation (List String) Integer)
           (ap:apply (pure +)
                     (validation:Ok 1)
                     (validation:Ok 2)))))

(define-test validation-err-case-1-test ()
  (matches (validation:Err (Cons "y error" (Nil)))
      (ap:apply (pure +)
                (validation:Ok 1)
                (validation:Err (make-list "y error")))))

(define-test validation-err-case-2-test ()
  (matches (validation:Err (Cons "x error" (Cons "y error" (Nil))))
      (ap:apply (pure +)
                (validation:Err (make-list "x error"))
                (Validation:Err (make-list "y error")))))

(define-test validation-into-result-case-1-test ()
  (matches (Ok 12)
      (validation:to-result (validation:Ok 12))))

(define-test validation-into-result-case-2-test ()
  (matches (Err (Cons "y error" (Nil)))
      (validation:to-result
       (ap:apply (pure +)
                 (validation:Ok 30)
                 (validation:Err (make-list "y error"))))))

(define-test result-into-validation-case-2-test ()
  (matches (validation:Err (Cons "y error" (Nil)))
      (ap:apply (pure +)
                (validation:from-result (Ok 30))
                (validation:from-result (Err (make-list "y error"))))))
