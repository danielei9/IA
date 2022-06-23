; clear
; load "ubicacion"
; reset
; run
;
; Sea un SP cuya BH inicial es BH={(lista a a b a)
; (par a 1) (par b 2)} y cuya BR se compone de la siguiente 
;   Solucion : 
;       R1:f1 { ?x=3, ?y=6, $?z=(8 5 10) }
(
    deffacts bh 
        (lista a a b a)
        (par a 1)
        (par b 2)
)

(defrule r1 
    ?f <- (lista $?x ?sym $?y) 
    (par ?sym ?num)
    =>
    (printout t x:  ?x  y:  ?y  sym: ?sym  num: ?num crlf)
    ;(assert (x:  ?x  y:  ?y sym: ?sym  num: ?num ) )
) 