
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
    (caquis 5)
    (uva 5)
    (lineaPedido manzana 0 naranja 0 caquis 0 uva 0)
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
    (lineaPedido $?w manzana ?manzanaLinea $?y)

     => ; si hay suficientes manzana ir a por ellas

    (println "Ir a por " ?cantPedido  " Manzana " )
   
    (retract  (manzana ?stockManzana)) ; eliminar stock para actualizar 
    (retract(pedido manzana ?cantPedido )) ; eliminar anterior pedido de manzana ya esta hecho
    (retract(lineaPedido manzana ?manzanaLinea naranja ?naranjaLinea caquis ?caquisLinea uva ?uvaLinea))

    (assert (lineaPedido manzana (+ ?cantPedido ?manzanaLinea) naranja ?naranjaLinea caquis ?caquisLinea uva ?uvaLinea)) ; actualizar la linea con pedido
    (assert ((manzana (- ?stockManzana ?cantPedido)))) ; actualizar stock
)

(defrule irAPorNaranjas
    ?f1 <- (pedido naranja ?cantPedido)
    (naranja ?stockNaranja)
    (test (<= ?cantPedido ?stockNaranja)); Comprozamos si hay suficientes naranjas
    (lineaPedido $?w naranja ?naranjaLinea $?y)

     => ; si hay suficientes naranjas ir a por ellas

    (println "Ir a por " ?cantPedido  " naranjas " )
   
    (retract  (manzana ?stockManzana)) ; eliminar stock para actualizar 
    (retract(pedido manzana ?cantPedido )) ; eliminar anterior pedido de naranjas ya esta hecho
    (retract(lineaPedido manzana ?naranjasLinea naranja ?naranjaLinea caquis ?caquisLinea uva ?uvaLinea))

    (assert (lineaPedido manzana (+ ?cantPedido ?naranjasLinea) naranja ?naranjaLinea caquis ?caquisLinea uva ?uvaLinea)) ; actualizar la linea con pedido
    (assert ((manzana (- ?stockManzana ?cantPedido)))) ; actualizar stock
)

(defrule irAPorManzanas
    ?f1 <- (pedido manzana ?cantPedido)
    (manzana ?stockManzana)
    (test (<= ?cantPedido ?stockManzana)); Comprozamos si hay suficientes manzanas
    (lineaPedido manzana ?manzanasLinea naranja ?naranjaLinea caquis ?caquisLinea uva ?uvaLinea)

     => ; si hay suficientes manzanas ir a por ellas

    (println "Ir a por " ?cantPedido  " Manzanas " )
   
    (retract  (manzana ?stockManzana)) ; eliminar stock para actualizar 
    (retract(pedido manzana ?cantPedido )) ; eliminar anterior pedido de manzanas ya esta hecho
    (retract(lineaPedido manzana ?manzanasLinea naranja ?naranjaLinea caquis ?caquisLinea uva ?uvaLinea))

    (assert (lineaPedido manzana (+ ?cantPedido ?manzanasLinea) naranja ?naranjaLinea caquis ?caquisLinea uva ?uvaLinea)) ; actualizar la linea con pedido
    (assert ((manzana (- ?stockManzana ?cantPedido)))) ; actualizar stock
)

(defrule irAPorManzanas
    ?f1 <- (pedido manzana ?cantPedido)
    (manzana ?stockManzana)
    (test (<= ?cantPedido ?stockManzana)); Comprozamos si hay suficientes manzanas
    (lineaPedido manzana ?manzanasLinea naranja ?naranjaLinea caquis ?caquisLinea uva ?uvaLinea)

     => ; si hay suficientes manzanas ir a por ellas

    (println "Ir a por " ?cantPedido  " Manzanas " )
   
    (retract  (manzana ?stockManzana)) ; eliminar stock para actualizar 
    (retract(pedido manzana ?cantPedido )) ; eliminar anterior pedido de manzanas ya esta hecho
    (retract(lineaPedido manzana ?manzanasLinea naranja ?naranjaLinea caquis ?caquisLinea uva ?uvaLinea))

    (assert (lineaPedido manzana (+ ?cantPedido ?manzanasLinea) naranja ?naranjaLinea caquis ?caquisLinea uva ?uvaLinea)) ; actualizar la linea con pedido
    (assert ((manzana (- ?stockManzana ?cantPedido)))) ; actualizar stock
)
; Not solutions
(defrule notSol
	(declare (salience -77))
    =>
	(printout t "No solutions" crlf)
	(printout t "in generations n: " ?*gen* crlf)
	(halt)
)

; FinishedOK
(defrule finishedOK
    (declare (salience 100))
    ?f3 <- (robot $?lastPos p ?row ?col going $?go buck 0 level ?level)
    (finish ?rowFinish ?colFinish)
    (test (and (= ?row ?rowFinish) (= ?col ?colFinish)))
    =>
    (printout t "package DONE" crlf)
    (printout t "level: " ?level crlf)
	(printout t "by: " ?f3 crlf)
    (printout t "way:"  crlf)
    (printout t "  - going: " $?go crlf)
    (printout t "  - return: " $?lastPos  ?row " " ?col  crlf)
	(printout t "RULES: " ?*gen* crlf)
    (halt)
)

;main function => runDev()
(deffunction main()
    (reset)
	(printout t "Put maxDeep level: ")
	(bind ?maxDeep (read))
	(printout t "Strategy?:" crlf "  1.- Breadth  2.- Depth" crlf )
    ;CREO QUE NO ME DA TIEMPO
	;(printout t "you want put N packages and N sites?: 1 Yes/0 No ")
    ;(bind ?keyNThings (read))
	;(if (= ?keyNThings 1)
	;    then    (?keyNThings 1)
	;    else    (?keyNThings 0)
    ;)
    (bind ?b (read))
	(if (= ?b 1)
	    then    (set-strategy breadth)
	    else    (set-strategy depth)
    )
    (assert (maxDeep ?maxDeep))
    (run)
)