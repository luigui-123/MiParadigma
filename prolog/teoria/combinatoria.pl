actividad(cine).
actividad(arjona).
actividad(princesas_on_ice).
actividad(pool).
actividad(bowling).
costo(cine, 400).
costo(arjona, 1750).
costo(princesas_on_ice, 2500).
costo(pool, 350).
costo(bowling, 300).

actividades(Plata, ActividadesPosibles):-
   findall(Actividad, actividad(Actividad), Actividades),
   actividadesPosibles(Actividades, Plata, ActividadesPosibles).

actividadesPosibles([] , _ , []).

actividadesPosibles([Actividad|Actividades], Plata, [Actividad|Posibles]):-
      costo(Actividad, Costo), 
      Plata > Costo, 
      PlataRestante is Plata - Costo,
      actividadesPosibles(Actividades, PlataRestante, Posibles).


actividadesPosibles([_|Actividades], Plata, Posibles):-
      actividadesPosibles(Actividades, Plata, Posibles).