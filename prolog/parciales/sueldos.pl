

departamento(ventas).
departamento(logistica).

empleado(kyle).
empleado(sherri).
empleado(gus).
empleado(ian).
empleado(trisha).
empleado(joshua).

gustaTrabajar(kyle,logistica).
gustaTrabajar(trisha,ventas).
gustaTrabajar(trisha,ventas).
gustaTrabajar(sherri,contabilidad).
gustaTrabajar(sherri,facturacion).
gustaTrabajar(sherri,cobranzas).

pertenece(kyle,ventas).
pertenece(sherri,logistica).
pertenece(ian,logistica).
pertenece(trisha,ventas).
pertenece(joshua,ventas).

ocupacion(kyle,asalariada(6),50).
ocupacion(sherri, asalariada(6),60).
ocupacion(gus,asalariada(8),60).
ocupacion(ian,jefe([kyle,rob,gus]),40).
ocupacion(trisha,jefe([ian,gus]),90).
ocupacion(joshua,independiente(arquitecto),55).

quiereGanar(kyle,70).
quiereGanar(trisha,250).
quiereGanar(joshua,70).
quiereGanar(sherri,200).
quiereGanar(ian,60).
quiereGanar(gus,70).

esPaggani(Departamento):-
  departamento(Departamento),
  forall(pertenece(Empleado,Departamento),ganaBien(Empleado)).


ganaBien(Empleado):-
    empleado(Empleado),
    tieneSalarioMayorAlPromedio(Empleado).

ganaBien(Empleado):-
    empleado(Empleado),
    ocupacion(Empleado,_,SalarioPersonal),
    cantidadDeSubordinados(Empleado,Cantidad),
    SalarioPersonal>20*Cantidad.
ganaBien(Empleado):-
    empleado(Empleado),
    ocupacion(Empleado,independiente(arquitecto),_).
ganaBien(Empleado):-
    empleado(Empleado),
    ocupacion(Empleado,independiente(_),SalarioPersonal),
    SalarioPersonal>70.

cantidadDeSubordinados(Empleado,Cantidad):-
    ocupacion(Empleado,jefe(Subordinados),_),
    length(Subordinados,Cantidad).

tieneSalarioMayorAlPromedio(Empleado):- 
    ocupacion(Empleado,asalariada(HorasTrabajadas),SalarioPersonal),
    salarioPromedio(HorasTrabajadas,SalarioPromedio),
    SalarioPersonal>SalarioPromedio.

salarioPromedio(HorasTrabajadas,SalarioPromedio):-
    findall(Salario,ocupacion(_,asalariada(HorasTrabajadas),Salario),Salarios),
    length(Salarios,Cantidad),
    sumlist(Salarios,Total),
    SalarioPromedio is Total/Cantidad.

estaEnProblemas(Departamento):-
    departamento(Departamento),
    forall(pertenece(Empleado,Departamento),not(gustaTrabajar(Empleado,Departamento))).


    
esDptoFeliz(Departamento):-
    departamento(Departamento),
    forall(pertenece(Empleado,Departamento),esEmpleadoFeliz(Empleado)).
esEmpleadoFeliz(Empleado):-
    ocupacion(Empleado,asalariada(HorasTrabajadas),_),
    HorasTrabajadas<7.

esEmpleadoFeliz(Empleado):-
    ocupacion(Empleado,jefe(Subordinados),_),
    tieneTres(Subordinados).
esEmpleadoFeliz(Empleado):-
    ocupacion(Empleado,jefe(),SalarioPersonal),
    SalarioPersonal>50.
esEmpleadoFeliz(Empleado):-
    ocupacion(Empleado,independiente(ingeniero),35).
    
tieneTres(Lista):-
    length(Lista,Cantidad),
    Cantidad=3.

estaEnProblemasEconomicos(ventas).
estaEnProblemasEconomicos(Departamento):-
    departamento(Departamento),
    forall(pertenece(Empleado,Departamento),not(estaSatisfecho(Empleado))).

estaSatisfecho(Empleado):
    empleado(Empleado),
    ocupacion(Empleado,_,SalarioPersonal),
    quiereGanar(Empleado,SalarioDeseado),
    SalarioDeseado<2*SalarioPersonal.

restar(ValorInicial,Contador):-Contador is ValorInicial - 1.