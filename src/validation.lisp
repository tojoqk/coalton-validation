(defpackage #:tokyo.tojo.validation/validation
  (:use #:coalton
        #:coalton-prelude)
  (:shadow #:Ok
           #:Err)
  (:export #:validation #:Ok #:Err
           #:to-result #:from-result)
  (:nicknames #:tokyo.tojo.validation))

(in-package #:tokyo.tojo.validation/validation)

(named-readtables:in-readtable coalton:coalton)

(coalton-toplevel
  (define-type (Validation :e :a)
    (Ok :a)
    (Err :e))

  (define-instance (Functor (Validation :e))
    (define (map f v)
      (match v
        ((Ok x) (Ok (f x)))
        ((Err e) (Err e)))))

  (define-instance (Semigroup :e => Applicative (Validation :e))
    (define pure Ok)
    (define (liftA2 op v1 v2)
      (match v1
        ((Ok x1)
         (match v2
           ((Ok x2) (pure (op x1 x2)))
           ((Err e2) (Err e2))))
        ((Err e1)
         (match v2
           ((Ok x2) (Err e1))
           ((Err e2) (Err (<> e1 e2))))))))

  (define-instance (Into (Validation :e :a) (Result :e :a))
    (define (into v)
      (match v
        ((Ok x) (coalton-prelude:Ok x))
        ((Err e) (coalton-prelude:Err e)))))

  (define-instance (Into (Result :e :a) (Validation :e :a))
    (define (into r)
      (match r
        ((coalton-prelude:Ok x) (Ok x))
        ((coalton-prelude:Err e) (Err e)))))

  (define-instance (Iso (Validation :e :a) (Result :e :a)))

  (declare to-result (Validation :e :a ->  Result :e :a))
  (define to-result into)

  (declare from-result (Result :e :a -> Validation :e :a))
  (define from-result into))
