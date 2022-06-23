; clear
; load "ubicacion"
; reset
; run
;
; Sea un SBR cuya BH inicial es BH={(lista 1 2 3 4)} y 
; cuya BR se compone de las siguientes reglas:
;   Solucion : 
;       R1:f1 { ?x=3, ?y=6, $?z=(8 5 10) }
(deffacts bh 
    (lista 1 2 3 4))

(defrule r1 
    ?f <- (lista ?x $?z) 
    =>
    (printout t x:  ?x ' ' z:  ?z crlf)
)
(defrule r2
    ?f <- (elemento ?x) 
    (elemento ?y )
    (test (< ?x ?y))
    =>
    (printout t y:  ?y ' ' x:  ?x crlf)
    (assert (x: ?x y:  ?y ))
)