(defpackage #:tokyo.tojo.validation/applicative
  (:use #:coalton
        #:coalton-prelude)
  (:export #:apply
           #:bind))
(in-package #:tokyo.tojo.validation/applicative)

(named-readtables:in-readtable coalton:coalton)

(coalton-toplevel
  (declare <*> (Applicative :f => :f (:a -> :b) -> :f :a -> :f :b))
  (define <*> (liftA2 id)))

(cl:defmacro apply (f cl:&rest args)
  `(op->l <*> ,f ,@args))

(cl:defmacro op->l (op x y cl:&rest args)
  (cl:cond
    ((cl:null args) `(,op ,x ,y))
    ((cl:null (cl:cdr args))
     `(,op (,op ,x ,y) ,(cl:car args)))
    (cl:t
     `(op->l ,op
             (,op ,x ,y)
             ,(cl:car args)
             ,(cl:cadr args)
             ,@(cl:cddr args)))))

(cl:defmacro bind (bindings cl:&body body)
  (cl:assert (cl:every #'(cl:lambda (b) (cl:symbolp (cl:first b)))
                       bindings))
  (cl:assert (cl:every  #'(cl:lambda (b) (cl:= 2 (cl:length b)))
                        bindings))
  `(apply (pure (fn ,(cl:loop :for b :in bindings :collect (cl:first b))
                  ,@body))
          ,@(cl:loop :for b :in bindings :collect (cl:second b))))
