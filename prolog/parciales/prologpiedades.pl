vive(juan,casa(120),almagro).
vive(nico,departamento(3,2),almagro).
vive(alf,departamento(3,1),almagro).
vive(julian,loft(2000),almagro).
vive(vale,departamento(4,1),flores).
vive(fer,casa(110),flores).
quiereMudarse(rocio,casa(90)).

barrio(almagro).
barrio(flores).


vivenEnCasasCopadas(Barrio):-
    barrio(Barrio),
    forall(vive(Persona,_,Barrio),viveEnCasaCopada(Persona)).
viveEnCasaCopada(Persona):-
    vive(Persona,Propiedad,_),
    esCopada(Propiedad).
esCopada(casa(Area)):-Area>100.
esCopada(departamento(CantidadAmbientes,_)):-CantidadAmbientes>3.
esCopada(departamento(_,CantidadBanios)):- CantidadBanios>1.
esCopada(loft(Anio)):- Anio>2015.

esBarrioCaro(Barrio):-
    barrio(Barrio),
    forall(vive(_,Propiedad,Barrio),not(esBarato(Propiedad))).

esBarato(loft(Anio)):-Anio<2005.
esBarato(casa(Area)):-Area<90.
esBarato(departamento(1,_)).
esBarato(departamento(2,_)).

costoCasa(juan,150000).
costoCasa(nico,80000).
costoCasa(julian,14000).
costoCasa(vale,95000).
costoCasa(fer,60000).

propiedad(Plata,PropietariosPosibles,Resto):-
    findall(Propietario,vive(Propietario,_,_),Propietarios),
    seLePuedeComprar(Propietarios,Plata,PropietariosPosibles),
    sobro(PropietariosPosibles,Plata,Resto).

seLePuedeComprar([],_,[]).
seLePuedeComprar([Propiedad|Propiedades],Plata,[Propiedad|Posibles]):-
    costoCasa(Propiedad,Costo),
    Plata>Costo,
    Resto is Plata - Costo,
    seLePuedeComprar(Propiedades,Resto,Posibles).

seLePuedeComprar([_|Propiedades],Plata,Posibles):-
    seLePuedeComprar(Propiedades,Plata,Posibles).

sobro(PropietariosPosibles,Plata,Resto):-
    findall(Precio,(member(Propietario,PropietariosPosibles),costoCasa(Propietario,Precio)),Precios),
    sumlist(Precios,PrecioTotal),
    Resto is Plata - PrecioTotal.
