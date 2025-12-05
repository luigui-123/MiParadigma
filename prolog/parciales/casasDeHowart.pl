
ingresante(harry).
ingresante(draco).
ingresante(harmonie).

casa(gryffindor).
casa(syltherin).
casa(ravenclaw).
casa(hufflepuff).

sangre(harry,mestiza).
sangre(draco,pura).
sangre(harmonie,impura).

caracteristicas(draco,[inteligente,orgulloso]).
caracteristicas(harry,[conjurado,amistoso,orgulloso,inteligente]).
caracteristicas(harmonie,[integrante,orgulloso,responsable]).

odiaria(harry,syltherin).
odiaria(draco,hufflepuff).

criterios(gryffindor,[coraje]).
criterios(syltherin,[orgulloso,integrante]).
criterios(ravenclaw,[integrante,responsable]).
criterios(hufflepuff,[amistoso]).

permiteEntrar(syltherin,Mago):-
    casa(syltherin),
    ingresante(Mago),
    sangre(Mago,Sangre),
    Sangre\=impura.    

permiteEntrar(Casa,Mago):-
    casa(Casa),
    Casa\=syltherin,
    ingresante(Mago).


tineCaracterApropiado(Mago,Casa):-
    ingresante(Mago),
    casa(Casa),
    caracteristicas(Mago,Caracteristicas),
    criterios(Casa,CaracteristicasRequeridas),
    forall(member(Requisito,CaracteristicasRequeridas),member(Requisito,Caracteristicas)).

sePuedeQuedar(Mago,Casa):-
    ingresante(Mago),
    casa(Casa),
    permiteEntrar(Casa,Mago),
    tineCaracterApropiado(Mago,Casa),
    not(odiaria(Mago,Casa)).

cadenaAmistades(Amigos):-
    forall(member(Amigo,Amigos),esAmistoso(Amigo)),
    puedenQuedarEnlaMismaCasa(Amigos).

puedenQuedarEnlaMismaCasa([],_).

puedenQuedarEnlaMismaCasa([Amigo|Amigos]):-
    nth0(0,Amigos,SiguienteAmigo),
    dosAmigosPuedeQuedarEnLaMismaCasa(Amigo,SiguienteAmigo),
    puedenQuedarEnlaMismaCasa(Amigos).

dosAmigosPuedeQuedarEnLaMismaCasa(AmigoUno,AmigoDos):-
    sePuedeQuedar(AmigoUno,Casa),
    sePuedeQuedar(AmigoDos,Casa).
esAmistoso(Mago):-
    caracteristicas(Mago,Caracteristicas),
    member(amistoso,Caracteristicas).
    