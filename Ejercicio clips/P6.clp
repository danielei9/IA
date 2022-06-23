;Supongamos que tenemos en una mesa varias cajas de distintos tamaños que queremos apilar en una torre,
;de mayor a menor tamaño, mediante acciones de ‘apilado’.
;La regla meta aclara el objetivo deseado.
;Definimos un SBR donde la BH inicial se describe de la siguiente forma:
;
;(watch facts)
;(watch activations)
;(watch rules)

(deffacts prueba (mesa 2 5 1 6 8 7 4 torre))

(defrule mesa-a-torre
    (mesa $?rest1 ?x $?rest3 torre $?rest1 ?y )
    (test (> ?y ?x))
        =>      
    (assert (mesa $?rest1 $?rest3 torre $?rest1 ?y ?x ))
)

;Mesa a torre vacia
(defrule mesa-a-torre-vacia
    (mesa $?rest1 ?x $?rest3 torre )
        =>
    (assert (mesa $?rest1 $?rest3 torre ?x ))
)

(defrule meta
    (mesa torre 1 2 4 5 6 7 8)
        =>
    (halt)  ;Para detener la activación de reglas se usa el comando (halt).
)