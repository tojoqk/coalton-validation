(in-package #:coalton-validation/test)

(define-test applicative-apply-list-test ()
  (matches (Cons 10 (Cons 14 (Cons 15 (Cons 21 (Nil)))))
      (ap:apply (pure *) (make-list 2 3) (make-list 5 7))))

(define-test applicative-apply-4-test ()
  (matches (Some 10)
      (ap:apply (pure (fn (x y z w) (+ x (+ y (+ z w)))))
                (Some 1) (Some 2) (Some 3) (Some 4))))

