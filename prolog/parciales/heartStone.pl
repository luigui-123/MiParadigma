/*base de hechos*/
jugador()


/*predicados auxiliares*/

nombre(jugador(Nombre,_,_,_,_,_), Nombre).
nombre(criatura(Nombre,_,_,_), Nombre).
nombre(hechizo(Nombre,_,_), Nombre).

vida(jugador(_,Vida,_,_,_,_), Vida).
vida(criatura(_,_,Vida,_), Vida).
vida(hechizo(_,curar(Vida),_), Vida).

danio(criatura(_,Danio,_), Danio).
danio(hechizo(_,danio(Danio),_), Danio).
mana(jugador(_,_,Mana,_,_,_), Mana).
mana(criatura(_,_,_,Mana), Mana).
mana(hechizo(_,_,Mana), Mana).

cartasMazo(jugador(_,_,_,Cartas,_,_), Cartas).
cartasMano(jugador(_,_,_,_,Cartas,_), Cartas).
cartasCampo(jugador(_,_,_,_,_,Cartas), Cartas).

/*ejercicio_1*/
carta(Jugador,Carta):-
    cartasMazo(Jugador,Mazo),
    member(Mazo,Carta).
cartas(Jugador,Carta):-
    cartasCampo(Jugador,Campo),
    member(Campo,Carta).
cartas(Jugador,Carta):-
    cartasMano(Jugador,Mano),
    member(Mano,Carta).
/*2)*/
esGuerrero(Jugador):-
    
    forall(carta(Jugador,Carta),esCriatura(Carta)).

esCriatura(criatura(_,_,_,_,_)).
/*3)*/
empezarTurno(jugador(Nombre, PuntosVida,Mana, [Cabeza|Cola], CartasMano, CartasCampo)
,jugador(Nombre, PuntosVida,NuevoMana,Cola, NuevasCartasMano, CartasCampo)):-
elSiguiente(Mana,NuevoMana),
append(CartasMano,[Cabeza],NuevasCartasMano).
/*4)*/
puedeJugarCarta(Jugador,Carta):-
    mana(Jugador,ManaJugador),
    costoMana(Carta,CostoMana),
    ManaJugador>CostoMana.
    

costoMana(criatura(_,_,_,CostoMana),CostoMana).
costoMana(hechizo(_,_,CostoMana),CostoMana).

puedeJugarCartas(Cartas,Jugador):-
    estanEnMano(Cartas,Jugador),
    forall(member(Cartas,Carta),puedeJugarCarta(Carta,Jugador)).

estanEnMano(Cartas,Jugador):-
    cartasMano(Jugador,Mano),
    forall(member(Cartas,Carta),member(Mano,Carta)).
/*5)*/

jugadas(Jugador,Cartas):-
    mana(Jugador,Mana),
    findall(Carta,carta(Jugador,Carta),Cartas),
    posiblesJugadas(Cartas,Mana,PosiblesCartas).

posiblesJugadas([],_,[]).
posiblesJugadas([Carta|Cartas],Mana,[Carta|Posibles]):-
    costoMana(Posible,CostoMana),
    RestoMana is Mana - CostoMana,
    RestoMana>=0.
posiblesJugadas([_|Cartas],Mana,PosiblesCartas):-
    posiblesJugadas(Cartas,Mana,PosiblesCartas).
elSiguiente(X,N):-N is X+1.

/*6)*/
cartaDaniana(Jugador,Carta):-
    danio(Carta,Danio),
    forall((jugador(Jugador,CartaPrueba),CartaPrueba\=Carta),Carta>CartaPrueba).

/*7*/
jugarContra(Carta,jugador(Nombre, PuntosVida, PuntosMana, CartasMazo, CartasMano, CartasCampo)
,jugador(Nombre, NuevosPuntosVida, PuntosMana, CartasMazo, CartasMano, CartasCampo)
):-
    esHechizo(Carta),
    danio(Carta,Danio),
    NuevosPuntosVida is PuntosVida-Danio.

esHechizo(hechizo(_,_,_)).

    
