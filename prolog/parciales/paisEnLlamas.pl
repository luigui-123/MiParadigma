tieneFoco(rosario, 20). 
tieneFoco(cosquin, 50). 
tieneFoco(km607, 300). 
lugar(rosario, ciudad(500)). 
lugar(cosquin, pueblo(20)). 
lugar(km607, campo). 
provincia(rosario, santaFe). 
provincia(cosquin, cordoba). 

ubicacion(rosario).
ubicacion(cosquin).
ubicacion(km607).

zona(santaFe).
zona(cordoba).

tienenFocosParecidos(LugarUno,LugarDos):-
    diferenciaTamanio(LugarUno,LugarDos,Diferencia),
    Diferencia<5.

diferenciaTamanio(LugarUno,LugarDos,Diferencia):-
    tieneFoco(LugarUno,TamanioUno),
    tieneFoco(LugarDos,TamanioDos),
    abs(TamanioDos-TamanioUno,Diferencia).

tieneFocoGrave(Lugar):-
    afectaHectareas(100,Lugar).

tieneFocoGrave(Lugar):-
    afectaHectareas(Cantidad,Lugar),
    Cantidad>20.
    esPoblado(Lugar).

esPoblado(Lugar):-
    lugar(Lugar,ciudad(_)).
esPoblado(Lugar):-
    lugar(Lugar,Pueblo(Poblacion)):-
    Poblacion>200000.

afectaHectareas(Cantidad,Lugar):-
    tieneFoco(Lugar,Cantidad).

buenPronostico(Lugar):-
    ubicacion(Lugar),
    not(tieneFocoGrave(Lugar)),
    forall(cercano(Lugar,OtroLugar),not(tieneFocoGrave(OtroLugar))).

provinciaCompremetida(Provincia):
    zona(Provincia)
    cantidadDeFocos(Provincia,Cantidad),
    Cantidad>4.

cantidadDeFocos(Provincia,Cantidad):-
    findall(Lugar,(provincia(Lugar,Provincia),tieneFoco(Lugar)),LugaresConFoco),
    length(LugaresConFoco,Cantidad).

provinciaAlHorno(Provincia):-
    provinciaCompremetida(Provicia),
    estaComplicada(Provincia).
estaComplicada(Provincia):-
    forall(provincia(Provincia,Lugar),tieneFoco(Lugar)).
estaComplicada(Provincia):-
    provincia(Provincia,Lugar),
    tieneFocoGrave(Lugar).