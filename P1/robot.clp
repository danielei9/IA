;**********************************************************************
;   Robot.clp
;   Daniel Burruchaga Sola
;**********************************************************************
; positions as "p FILA COLUMNA"
; origin in 1 1
; Define factual basis db as name x y;
;
; 1º (clear) 
; 2º (load ubi) 
; 3º (reset) 
; 4º (run) 

;table
(deffacts table
    (ground filas 5 columnas 8)
    (final 1 3)
    (package 4 5)
    (origin 2 2)
)

; blocks
(deffacts blocks
    (block 1 4)
    (block 3 1)
    (block 3 4)
    (block 3 5)
    (block 3 6)
    (block 4 4)
    (block 5 4)
)

(defrule avanzar
 ?f1 <- (robot ?x ?y)
 (test (< ?z ?y)) ;; comprobamos si ?z es menor que ?y
 =>
(retract ?f1)
(assert (lista $?x ?z ?y $?w))) ;; intercambiamos elementos
