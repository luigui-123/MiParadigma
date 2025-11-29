padre(tatara, bisa).
padre(bisa, abu).
padre(abu, padre).
padre(padre, hijo).

ancestro(Padre, Persona):-padre(Padre, Persona).
ancestro(Ancestro, Persona):-
    padre(Padre, Persona),
    ancestro(Ancestro, Padre).

mayor(elefante,caballo).
mayor(caballo,perro).
mayor(perro,hormiga).

esMayor(A,B):-
    mayor(A,B).
esMayor(A,B):-
    mayor(A,X),
    esMayor(X,B).