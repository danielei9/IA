;Definir Base de hechos  name x y;
;1º clear 2º load 3º reset 
(deffacts datos
    (robot 0 1) 
    (casa 2 4)
    (paquete 1 1)
    (obstaculo 0 2)
    (obstaculo 3 4)
    (obstaculo 3 0)
    (obstaculo 3 1)
    (obstaculo 3 2)
    (obstaculo 4 2)
    (obstaculo 5 2)
)

(defrule avanzar
 ?f1 <- (robot ?x ?y)
 (test (< ?z ?y)) ;; comprobamos si ?z es menor que ?y
 =>
(retract ?f1)
(assert (lista $?x ?z ?y $?w))) ;; intercambiamos elementos