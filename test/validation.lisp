(in-package #:coalton-validation/test)

(define-test validation-ok-test ()
  (matches (validation:Ok 3)
      (the (validation:Validation (List String) Integer)
           (ap:let ((x (validation:Ok 1))
                    (y (validation:Ok 2)))
             (+ x y)))))

(define-test validation-err-case-1-test ()
  (matches (validation:Err (Cons "y error" (Nil)))
      (ap:let ((x (validation:Ok 1))
               (y (validation:Err
                   (make-list "y error"))))
        (+ x y))))

(define-test validation-err-case-2-test ()
  (matches (validation:Err (Cons "x error" (Cons "y error" (Nil))))
      (ap:let ((x (validation:Err (make-list "x error")))
               (y (Validation:Err (make-list "y error"))))
        (+ x y))))

(define-test validation-into-result-case-1-test ()
  (matches (Ok 12)
      (validation:to-result (validation:Ok 12))))

(define-test validation-into-result-case-2-test ()
  (matches (Err (Cons "y error" (Nil)))
      (validation:to-result
       (ap:let ((x (validation:Ok 30))
                (y (validation:Err
                    (make-list "y error"))))
         (+ x y)))))

(define-test result-into-validation-case-2-test ()
  (matches (validation:Err (Cons "y error" (Nil)))
      (ap:let ((x (validation:from-result (Ok 30)))
               (y (validation:from-result (Err (make-list "y error")))))
        (+ x y))))
