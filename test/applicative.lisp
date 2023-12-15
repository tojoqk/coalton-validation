(in-package #:coalton-validation/test)

(define-test applicative-apply-list-test ()
  (matches (Cons 10 (Cons 14 (Cons 15 (Cons 21 (Nil)))))
      (ap:apply * (make-list 2 3) (make-list 5 7))))

(define-test applicative-let-optional-test ()
  (matches (None)
      (ap:apply + (Some 3) None))
  (matches (Some 5)
      (ap:apply + (Some 3) (Some 2))))

(define-test applicative-apply-4 ()
  (matches (Some 10)
      (ap:apply (fn (x y z w) (+ x (+ y (+ z w))))
                (Some 1) (Some 2) (Some 3) (Some 4))))

(define-test applicative-let-4 ()
  (matches (Some 10)
      (ap:let ((x (Some 1))
               (y (Some 2))
               (z (Some 3))
               (w (Some 4)))
        (+ x (+ y (+ z w))))))

