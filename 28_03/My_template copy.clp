
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
; Rule down
(defrule irAPorManzanas
    ?f1 <- (pedido manzana ?cantPedido)
    (manzana ?stockManzana)
    (test (<= ?cantPedido ?stockManzana)); Comprozamos si hay suficientes manzanas
    
     => ; si hay suficientes manzanas ir a por ellas
    (println "Ir a por " (+ ?cantPedido 1) " Manzanas " )
    (retract(pedido manzana ?cantPedido ))


    (maxDeep ?maxDeep)
    (ground rows ?numRows $?)
    (not (block =(+ ?row 1) ?col)); not a block
    (test (< ?level ?maxDeep))    ; We can go one level deeper? 
    (test (not (member$ (create$ p (+ ?row 1) ?col) $?lastPos)))  ;its not the same as later
    =>
    ;(println "DOWN " (+ ?row 1) " col " ?col " buck = " ?stateBuck )
    (assert (robot $?lastPos p ?row ?col p (+ ?row 1) ?col going $?go buck ?stateBuck level (+ ?level 1))) ; create assert with new position
    (bind ?*gen* (+ ?*gen* 1)) ; add to gen counter +1
)

; Rule left
(defrule left
    ?f1 <- (robot $?lastPos p ?row ?col going $?go buck ?stateBuck level ?level)
    (maxDeep ?maxDeep)
    (not (block ?row =(- ?col 1)))
    (test (> ?col 1))
    (test (< ?level ?maxDeep))    
    (test (not (member$ (create$ p ?row (- ?col 1)) $?lastPos)))   
    =>
    (assert (robot $?lastPos p ?row ?col p ?row (- ?col 1) going $?go buck ?stateBuck level (+ ?level 1)))
    (bind ?*gen* (+ ?*gen* 1))
)

; Rule rigth
(defrule rigth
    ?f1 <- (robot $?lastPos p ?row ?col going $?go buck ?stateBuck level ?level)
    (maxDeep ?maxDeep)
    (ground $? cols ?num_cols)
    (not (block ?row =(+ ?col 1)))
    (test (< ?col ?num_cols))
    (test (< ?level ?maxDeep))   
    (test (not (member$ (create$ p ?row (+ ?col 1)) $?lastPos)))    
    =>
    (assert (robot $?lastPos p ?row ?col p ?row (+ ?col 1) going $?go buck ?stateBuck level (+ ?level 1)))
    (bind ?*gen* (+ ?*gen* 1))
)

; Rule up
(defrule up
    ?f1 <- (robot $?lastPos p ?row ?col going $?go buck ?stateBuck level ?level)
    (maxDeep ?maxDeep)
    (not (block =(- ?row 1) ?col))
    (test (> ?row 1))
    (test (< ?level ?maxDeep)) 
    (test (not (member$ (create$ p (- ?row 1) ?col) $?lastPos)))    
    =>
    (assert (robot $?lastPos p ?row ?col p (- ?row 1) ?col going $?go buck ?stateBuck level (+ ?level 1)))
    (bind ?*gen* (+ ?*gen* 1))
)

; Rule take box
(defrule takeBox
    (declare (salience 70))
    ?f2 <- (robot $?lastPos p ?row ?col going $?go buck 0 level ?level)
    (package ?rowPackage ?colPackage)
    (test (and (= ?row ?rowPackage) (= ?col ?colPackage)))
    =>
    (printout t "¡TAKE PACKAGE!" crlf)
    (printout t "package by " ?f2 " in level: " ?level crlf)
    (assert (robot p ?row ?col going $?lastPos p ?row ?col buck 1 level ?level))
    (bind ?*gen* (+ ?*gen* 1))
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