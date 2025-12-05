tarea(ordenarCuarto).
tarea(limpiarBanio).
tarea(limpiarTecho).
tarea(cortarPasto).
tarea(encerarPisos).

precio(ordenarCuarto,20).
precio(limpiarBanio,13).
precio(limpiarTecho,30).
precio(cortarPasto,40).
precio(encerarPisos,29).

herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

cliente(maria).
cliente(lucas).
cliente(jose).
cliente(luis).
cliente(marcelo).

tareaPedida(maria,ordenarCuarto,12).
tareaPedida(maria,limpiarBanio,13).
tareaPedida(jose,encerarPisos,20).
tareaPedida(lucas,cortarPasto,30).
tareaPedida(marcelo,limpiarTecho,37).
tareaPedida(luis,cortarPasto,20).


/*1)*/
integrante(egon).
integrante(peter).
integrante(ray).
integrante(winston).


tiene(egon,aspiradora(200)).
tiene(egon,trapeador).
tiene(peter,trapeador).
tiene(peter,sopapa).
tiene(winston,varitaDeNeutrones).

/*2)*/
satisfaceFuncionalidad(Herramienta,Integrante):-
    integrante(Integrante),
    tiene(Integrante,HerramientaPersonal),
    seUsanParaLoMismo(Herramienta,HerramientaPersonal).

seUsanParaLoMismo(HerramientaUno,HerramientaDos):-
    herramientasRequeridas(_,Herramientas),
    member(HerramientaUno,Herramientas),
    member(HerramientaDos,Herramientas).

seUsaPara(Herramienta,Necesidad):-
    herramientasRequeridas(Necesidad,Herramientas),
    member(Herramienta,Herramientas).

satisfaceHerramienta(Herramienta,Integrante):-
    integrante(Integrante),
    tiene(Integrante,Herramienta).

satisfaceHerramienta(aspiradora(Potencia),Integrante):-
    integrante(Integrante),
    
    tieneUnaMasPotente(Integrante,Potencia).

tieneUnaMasPotente(Integrante,Potencia):-
    tiene(Integrante,(aspiradora(PotenciaIndividual))),
    PotenciaIndividual>=Potencia.
/*3)*/
puedeHacer(Integrante,Tarea):-
    integrante(Integrante),
    tiene(Integrante,varitaDeNeutrones),
    herramientasRequeridas(Tarea,_).

puedeHacer(Integrante,Tarea):-
    integrante(Integrante),
    herramientasRequeridas(Tarea,Herramientas),
    forall(member(Herramienta,Herramientas),tiene(Integrante,Herramienta)).

/*4)*/

cobroXTarea(Tarea,MetrosCuadrados,ACobrar):-
    tarea(Tarea),
    precio(Tarea,PrecioUnitario),
    ACobrar is PrecioUnitario*MetrosCuadrados.
cobroXPedido(Cliente,ACobrar):-
    cliente(Cliente),
    findall(Precio,(tareaPedida(Cliente,Tarea,MetrosCuadrados),cobroXTarea(Tarea,MetrosCuadrados,Precio)),Precios),
    sumlist(Precios,ACobrar).

/*5)*/
aceptaPedido(Empleado,Cliente):-
    integrante(Empleado),
    cliente(Cliente),
    forall(tareaPedida(Cliente,Tarea,_),(puedeHacer(Empleado,Tarea),estaDispuesto(Empleado,Tarea))).

estaDispuesto(ray,Cliente):- 
    cliente(Cliente),
    forall(tareaPedida(Cliente,Tarea,_),Tarea\=limpiarTecho).


estaDispuesto(winston,Cliente):-
    cliente(Cliente),
    cobroXPedido(Cliente,ACobrar),
    ACobrar>500.

estaDispuesto(egon,Cliente):-
    cliente(Cliente),
    forall(tareaPedida(Cliente,Tarea,_),not(esComplicada(Tarea))).

estaDispuesto(peter,Cliente):-
    cliente(Cliente),
    tareaPedida(Cliente,_,_).


esComplicada(Tarea):-
    tarea(Tarea),
    herramientasRequeridas(Tarea,Herramientas),
    length(Herramientas,Cantidad),
    Cantidad>2.

/*6)*/




