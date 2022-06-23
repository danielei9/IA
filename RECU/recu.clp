
;(watch facts)
;(watch activations)
;(watch rules)

(deffacts prueba (torre1 A B C torre2 E D brazo mesa))

;torre 1 a brazo
(defrule torre1-brazo (declare (salience 15))
    ?f <-(torre1 ?x $?rest1 torre2 $?rest2 brazo mesa $?rest3)
        =>      
    (retract ?f)
    (assert (torre1 $?rest1 torre2 $?rest2 brazo ?x mesa $?rest3))   
)
;torre 2 a brazo
(defrule torre2-brazo (declare (salience 10))
    ?f <-(torre1 $?rest1 torre2 ?x $?rest2 brazo mesa $?rest3 )
        =>      
    (retract ?f)
    (assert (torre1 $?rest1 torre2 $?rest2 brazo ?x mesa $?rest3))   
)
;brazo mesa
(defrule brazo-mesa (declare (salience 20))
    ?f <-(torre1 $?rest1 torre2 $?rest2 brazo ?a mesa $?rest3 )
        =>      
    (retract ?f)
    (assert (torre1 $?rest1 torre2 $?rest2 brazo mesa ?a $?rest3))   
)

(defrule mesa-torre (declare (salience 20))
    ?f <-(torre1 torre2 brazo mesa $?rest3 ?a $?rest4 )
    ?f <-(torre1 torre2 brazo mesa $?rest ?a )
        =>      
    (retract ?f)

    (assert (torre1 $?rest1 torre2 $?rest2 brazo mesa ?a $?rest3))   
)



(defrule meta   (salience 100)
   (torre1 D B E A torre2 C brazo mesa)
        =>
    (halt)  ;Para detener la activación de reglas se usa el comando (halt).
)