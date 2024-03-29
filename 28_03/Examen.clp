
;**********************************************************************
;   Robot.clp
;   Daniel Burruchaga Sola
;**********************************************************************
;;; positions as "p row col"
;;; origin in 1 1

; 1º (clear) 
; 2º (load C:\Users\dbs99\Desktop\InteligenciaArtificial\InteligenciaArtificial\Clips\robot_recoge_paquetes.clp) 
; 3º (reset) 
; 4º (runDev) 
; 5º (run) 

; the gen represent the number of generations the code makes 
(defglobal ?*gen* = 0)

; inicializamos el stock
(deffacts init
    (manzana 5)
    (naranja 5)
    (caqui 5)
    (uva 5)
    
    ; lo que se encuentra ya en el deposito de cajas del pedido
    (lineaPedido manzana 0 naranja 0 caqui 0 uva 0) 
)

; pedido
(deffacts pedido
    (pedido manzana 3 )
    (pedido naranja 2 )
    (pedido uva 1 )
)

(defrule )
(defrule irAPorManzanas
    ?f1 <- (pedido manzana ?cantPedido)
    (manzana ?stockManzana)
    (test (<= ?cantPedido ?stockManzana)); Comprozamos si hay suficientes manzana
    (lineaPedido manzana ?manzanasLinea naranja ?naranjaLinea caqui ?caquiLinea uva ?uvaLinea)

     => ; si hay suficientes manzana ir a por ellas

    (println "Ir a por " ?cantPedido  " Manzana " )
   
    (retract  (manzana ?stockManzana)) ; eliminar stock para actualizar 
    (retract(pedido manzana ?cantPedido )) ; eliminar anterior pedido de manzana ya esta hecho
    (retract(lineaPedido manzana ?manzanaLinea naranja ?naranjaLinea caqui ?caquiLinea uva ?uvaLinea))

    (assert (lineaPedido manzana (+ ?cantPedido ?manzanaLinea) naranja ?naranjaLinea caqui ?caquiLinea uva ?uvaLinea)) ; actualizar la linea con pedido
    (assert ((manzana (- ?stockManzana ?cantPedido)))) ; actualizar stock
)

(defrule irAPorNaranjas
    ?f1 <- (pedido naranja ?cantPedido)
    (naranja ?stockNaranja)
    (test (<= ?cantPedido ?stockNaranja)); Comprozamos si hay suficientes naranjas
    (lineaPedido manzana ?manzanaLinea naranja ?naranjaLinea caqui ?caquiLinea uva ?uvaLinea)

     => ; si hay suficientes naranjas ir a por ellas

    (println "Ir a por " ?cantPedido  " naranjas " )
   
    (retract  (naranja ?stockNaranja)) ; eliminar stock para actualizar 
    (retract(pedido naranja ?cantPedido )) ; eliminar anterior pedido de naranjas ya esta hecho
    (retract(lineaPedido manzana ?manzanaLinea naranja ?naranjaLinea caqui ?caquiLinea uva ?uvaLinea))

    (assert (lineaPedido manzana ?manzanaLinea naranja (+ ?cantPedido ?naranjaLinea) caqui ?caquiLinea uva ?uvaLinea)) ; actualizar la linea con pedido
    (assert ((naranja (- ?stockNaranja ?cantPedido)))) ; actualizar stock
)

(defrule irAPorCaqui
    ?f1 <- (pedido caqui ?cantPedido)
    (caqui ?stockCaqui)
    (test (<= ?cantPedido ?stockCaqui)); Comprozamos si hay suficientes caqui
    (lineaPedido manzana ?manzanaLinea naranja ?naranjaLinea caqui ?caquiLinea uva ?uvaLinea)

     => ; si hay suficientes caqui ir a por ellas

    (println "Ir a por " ?cantPedido  " caqui " )
   
    (retract  (caqui ?stockCaqui)) ; eliminar stock para actualizar 
    (retract(pedido caqui ?cantPedido )) ; eliminar anterior pedido de caqui ya esta hecho
    (retract(lineaPedido manzana ?manzanaLinea naranja ?naranjaLinea caqui ?caquiLinea uva ?uvaLinea))

    (assert (lineaPedido manzana ?manzanaLinea naranja ?naranjaLinea caqui (+ ?cantPedido ?caquiLinea ) uva ?uvaLinea)) ; actualizar la linea con pedido
    (assert ((caqui (- ?stockCaqui  ?cantPedido)))) ; actualizar stock
)


(defrule irAPorUvas
    ?f1 <- (pedido uva ?cantPedido)
    (uva ?stockUva)
    (test (<= ?cantPedido ?stockUva)); Comprozamos si hay suficientes uva
    (lineaPedido manzana ?manzanaLinea naranja ?naranjaLinea caqui ?caquiLinea uva ?uvaLinea)

     => ; si hay suficientes uva ir a por ellas

    (println "Ir a por " ?cantPedido  " uva " )
   
    (retract  (uva ?stockUva)) ; eliminar stock para actualizar 
    (retract(pedido uva ?cantPedido )) ; eliminar anterior pedido de naranjas ya esta hecho
    (retract(lineaPedido manzana ?manzanaLinea naranja ?naranjaLinea caqui ?caquiLinea uva ?uvaLinea))

    (assert (lineaPedido manzana ?manzanaLinea naranja ?naranjaLinea caqui ?caquiLinea uva  (+ ?cantPedido ?uvaLinea))) ; actualizar la linea con pedido
    (assert ((uva (- ?stockUva ?cantPedido)))) ; actualizar stock
)

; Not solutions
(defrule noStock
	(declare (salience -77))
    =>
	(printout t "No Stock" crlf)
	(halt)
)

; FinishedOK
(defrule finishedOK
    (declare (salience 100))
    ?f3 <- (pedido $?w)
    (not (test  (> (length $?w) 0)))
    =>
    (printout t " DONE" crlf)
    (halt)
)

;main function => runDev()
(deffunction main()
    (reset)
    (run)
)