https://github.com/danielei9/IA/tree/Develop
En el github puedes encontrarlo en la rama Develop, 
Lo primero que he realizado es buscar un manual con ejemplos que recomiendo bastante la verdad 
esta adjunto en la practica,
despues de esto he empezado por crear el tablero con sus "fichas" bloques,paquete final... 
"""
(deffacts table
    (ground rows 5 cols 8)
    (package 4 5)
    
    (finish 1 3)
)
"""
luego los bloques, al principio pensaba incluirlos en table pero finalmente opte por esta opción
"""
; blocks
(deffacts blocks
    (block 1 4)
    (block 3 1)
    (block 3 4)
    (block 3 5)
    (block 3 6)
    (block 4 4)
    (block 5 4)
)
"""
El ultimo apartado de la avanzada no me ha dado tiempo del todo.

Creamos un origen donde robot(obj) p(posicion) x y going(esta yendo no volviendo) buck(si tiene el paquete)
 0 level(saber el nivel) 0 
"""
(deffacts origin
    (robot p 4 1 going buck 0 level 0)
)
"""
creo una regla que uso de "template" para las demas donde compruebo:
	- donde se encuentra 
	- si debe hacer un nivel mas
	- si puede realizar la accion
e indico el nuevo evento en un assert, añadiendo +1 al numero de generaciones
"""
(defrule down
    ?f1 <- (robot $?lastPos p ?row ?col going $?go buck ?stateBuck level ?level)
    (maxDeep ?maxDeep)
    (ground rows ?numRows $?)
    (not (block =(+ ?row 1) ?col)); not a block
    (test (< ?row ?numRows)) ;must be in the table
    (test (< ?level ?maxDeep))    ; We can go one level deeper? 
    (test (not (member$ (create$ p (+ ?row 1) ?col) $?lastPos)))  ;its not the same as later
    =>
    ;(println "DOWN " (+ ?row 1) " col " ?col " buck = " ?stateBuck )
    (assert (robot $?lastPos p ?row ?col p (+ ?row 1) ?col going $?go buck ?stateBuck level (+ ?level 1)))
 ; create assert with new position
    (bind ?*gen* (+ ?*gen* 1)) ; add to gen counter +1
)
"""
Tambien tengo la regla de:
	- coger el paquete
	- finish OK 
	- no solucion
a todas estas reglas les llamamos desde una función que he creado main()
desde la cual pregunto si la estrategia y el maximo de profundidad finalmente desde aqui llamo a run 
entonces solo con ejecutar esta función ya esta OK.