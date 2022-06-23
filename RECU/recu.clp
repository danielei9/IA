
;(watch facts)
;(watch activations)
;(watch rules)

(deffacts prueba (torre1 A B C torre2 E D mesa))

;torre 1 a mesa
(defrule torre-mesa (declare (salience 10))
    ?f <-(torre1 ?x $?rest2 torre2 $?rest1 mesa )
        =>      
    (retract ?f)
    (assert (torre1 $?rest2 torre2 $?rest1 mesa ?x))
    
)

(defrule meta   (salience 100)
   (torre1 $?rest2 torre2 $?rest1 mesa ?x)
        =>
    (halt)  ;Para detener la activación de reglas se usa el comando (halt).
)