; clear
; load "ubicacion"
; reset
; run
;
; Sea un SBR cuya BH inicial es BH={(lista 3 6 8 5 10)} y cuya BR se compone de las siguientes reglas:
; Solucion : 
;   R1:f1 { ?x=3, ?y=6, $?z=(8 5 10) }
(deffacts bh 
    (lista 3 6 8 5 10))

(defrule r1 
    ?f <- (lista ?x ?y $?z) 
    (test (< ?x ?y))
    =>
    then (printout t y:  ?y ' ' x:  ?x crlf)
    (assert (y: ?y x:  ?x ))
)