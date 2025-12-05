
puntajes(hernan,[3,5,8,6,9]).
puntajes(julio,[9,7,3,9,10,2]).
puntajes(ruben,[3,5,3,8,3]).
puntajes(roque,[7,10,10]).

competidor(hernan).
competidor(julio).
competidor(ruben).
competidor(roque).
puntosObtenidos(Salto,Competidor,Puntaje):-
    competidor(Competidor),
    puntajes(Competidor,Puntajes),
    nth1(Salto,Puntajes,Puntaje).

estaDescalficado(Competidor):-
    competidor(Competidor),
    hizoMuchosSaltos(Competidor).

hizoMuchosSaltos(Competidor):-
    puntajes(Competidor,Puntajes),
    length(Puntajes,Cantidad),
    Cantidad>5.

clasificaALaFinal(Competidor):-
    competidor(Competidor),
    puntosTotales(Competidor,Puntos),
    Puntos>=28.
clasificaALaFinal():-
    competidor(Competidor),
    saltosDeOchoPuntosOMas(Competidor,Cantidad),
    Cantidad>2.
puntosTotales(Competidor,Puntos):-
    puntajes(Competidor,Puntajes),
    sumlist(Puntajes,Puntos).

saltosDeOchoPuntosOMas(Competidor,Cantidad):-
    competidor(Competidor),
    puntajes(Competidor,Puntajes),
    filter(mayorOIgualAOcho,Puntajes,NuevosPuntajes),
    length(NuevosPuntajes,Cantidad).

mayorOIgualAOcho(N):-N>=8.

maplist_1(_, [], []).
maplist_1(PredicadoTransformador, [Orig|Origs], [Transf|Transfs]):-
     call(PredicadoTransformador, Orig, Transf),
     maplist_1(PredicadoTransformador, Origs, Transfs).

filter(Criterio, ListaOriginal, ListaNueva):-
   findall(Elem, 
           (member(Elem, ListaOriginal), call(Criterio, Elem)),
           ListaNueva).
siguiente(X,N):-N is X+1.