; clear
; load "ubicacion"
; reset
; run
;
; Determina el conjunto de instancias de R1 que se generan tras la aplicación del proceso de pattern-matching.
; Solucion : 
;   R1:f1 { $?x=(7), ?y=3, ?z=2, $?w=(5) }
;   R1:f1 { $?x=(), ?y=7, ?z=3, $?w=(2 5) }

(deffacts bh 
    (lista 7 3 2 5))

(defrule r1 
    ?f <- (lista $?x ?y ?z $?w) 
    (test (< ?z ?y))
    =>
    then (printout t y:  ?y ' ' Z:  ?z crlf)
    (assert (y: ?y Z:  ?z ))

)