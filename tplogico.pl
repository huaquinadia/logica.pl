partido([frank,claire,catherine], rojo).
partido([garrett,linda], azul).
partido([jackie,seth], amarillo).
partido([],violeta).

edad(50,frank).
edad(52,claire).
edad(64,garrett).
edad(26,peter).
edad(38,jackie).
edad(30,linda).
edad(59,catherine).

sePresenta(rojo,[buenosAires,santaFe,cordoba,chubut,tierraDelFuego,sanLuis]).
sePresenta(azul,[buenosAires,chaco,tierraDelFuego,sanLuis,neuquen]).
sePresenta(amarillo,[chaco,formosa,tucuman,salta,santaCruz,laPampa,corrientes,misiones,buenosAires]).


habitantes(buenosAires, 15355000).
habitantes(chaco, 1143201).
habitantes(tierraDelFuego, 160720).
habitantes(sanLuis, 489255).
habitantes(neuquen, 637913).
habitantes(santaFe, 3397532).
habitantes(cordoba, 3567654).
habitantes(chubut, 577466).
habitantes(formosa, 527895).
habitantes(tucuman, 1687305).
habitantes(salta, 1333365).
habitantes(santaCruz, 273964).
habitantes(laPampa, 349299).
habitantes(corrientes, 992595).
habitantes(misiones, 1189446).

intencionDeVotoEn(buenosAires, rojo, 40).
intencionDeVotoEn(buenosAires, azul, 30).
intencionDeVotoEn(buenosAires, amarillo, 30).
intencionDeVotoEn(chaco, rojo, 50).
intencionDeVotoEn(chaco, azul, 20).
intencionDeVotoEn(chaco, amarillo, 0).
intencionDeVotoEn(tierraDelFuego, rojo, 40).
intencionDeVotoEn(tierraDelFuego, azul, 20).
intencionDeVotoEn(tierraDelFuego, amarillo, 10).
intencionDeVotoEn(sanLuis, rojo, 50).
intencionDeVotoEn(sanLuis, azul, 20).
intencionDeVotoEn(sanLuis, amarillo, 0).
intencionDeVotoEn(neuquen, rojo, 80).
intencionDeVotoEn(neuquen, azul, 10).
intencionDeVotoEn(neuquen, amarillo, 0).
intencionDeVotoEn(santaFe, rojo, 20).
intencionDeVotoEn(santaFe, azul, 40).
intencionDeVotoEn(santaFe, amarillo, 40).
intencionDeVotoEn(cordoba, rojo, 10).
intencionDeVotoEn(cordoba, azul, 60).
intencionDeVotoEn(cordoba, amarillo, 20).
intencionDeVotoEn(chubut, rojo, 15).
intencionDeVotoEn(chubut, azul, 15).
intencionDeVotoEn(chubut, amarillo, 15).
intencionDeVotoEn(formosa, rojo, 0).
intencionDeVotoEn(formosa, azul, 0).
intencionDeVotoEn(formosa, amarillo, 0).
intencionDeVotoEn(tucuman, rojo, 40).
intencionDeVotoEn(tucuman, azul, 40).
intencionDeVotoEn(tucuman, amarillo, 20).
intencionDeVotoEn(salta, rojo, 30).
intencionDeVotoEn(salta, azul, 60).
intencionDeVotoEn(salta, amarillo, 10).
intencionDeVotoEn(santaCruz, rojo, 10).
intencionDeVotoEn(santaCruz, azul, 20).
intencionDeVotoEn(santaCruz, amarillo, 30).
intencionDeVotoEn(laPampa, rojo, 25).
intencionDeVotoEn(laPampa, azul, 25).
intencionDeVotoEn(laPampa, amarillo, 40).
intencionDeVotoEn(corrientes, rojo, 30).
intencionDeVotoEn(corrientes, azul, 30).
intencionDeVotoEn(corrientes, amarillo, 10).
intencionDeVotoEn(misiones, rojo, 90).
intencionDeVotoEn(misiones, azul, 0).
intencionDeVotoEn(misiones, amarillo, 0).

%------------2
compite(Candidato,Partido):-partido(Personas,Partido),member(Candidato,Personas).
participa(Partido,Provincia):-sePresenta(Partido,Provincias),member(Provincia,Provincias).
esPicante(Provincia):-habitantes(Provincia,Cantidades),Cantidades>1000000,findall(Partido,participa(Partido,Provincia),Partidos),length(Partidos,Cantidad),Cantidad>=2.
%--------------------------3

leGanaA(Candidato1,Candidato2,Provincia):-compite(Candidato1,Partido1),compite(Candidato2,Partido2),participa(Partido1,Provincia),not(participa(Partido2,Provincia)).

leGanaA(Candidato1,Candidato2,Provincia):-compite(Candidato1,Partido1),compite(Candidato2,Partido2),intencionDeVotoEn(Provincia,Partido1,Porcentaje1),intencionDeVotoEn(Provincia,Partido2,Porcentaje2),Porcentaje1>Porcentaje2.

leGanaA(Candidato1,Candidato2,Provincia):-participa(Partido,Provincia),compite(Candidato1,Partido),compite(Candidato2,Partido).
%-----------4
participaCandidato(Candidato,Partido,Provincia):-participa(Partido,Provincia),compite(Candidato,Partido).

candidatoJoven(Partido,Candidato1):-findall(edad(Edad,Candidato),(edad(Edad,Candidato),compite(Candidato,Partido)),Tabla),min_member(Chico,Tabla),edad(Edad,Candidato1)=Chico.
ganaSiempre(Candidato,Partido):-participaCandidato(Candidato,Partido,Provincia),leGanaA(Candidato,_,Provincia).

elGranCandidato(Candidato1):-ganaSiempre(Candidato1,Partido),candidatoJoven(Partido,Candidato1).
%-------------------------- ---5
partidoGana(Provincia,Partido,Porcentaje1):-participa(Partido,Provincia),findall(Porcentaje,intencionDeVotoEn(Provincia,_,Porcentaje),Tabla),max_member(Mayor,Tabla),Mayor==Porcentaje1.

ajusteConsultora(Provincia, Partido, Porcentaje1):-intencionDeVotoEn(Provincia,Partido,Porcentaje), partidoGana(Provincia,Partido,Porcentaje),Porcentaje1 is Porcentaje -20.
ajusteConsultora(Provincia,Partido, Porcentaje1):-intencionDeVotoEn(Provincia,Partido,Porcentaje),not(partidoGana(Provincia,Partido,Porcentaje)),Porcentaje1 is Porcentaje + 5.
%------------------------6

promesa(azul(inflacion(2,4),aConstruir([(1000,hospitales),(100,jardines),(5,escuelas)]))).
promesa(rojo(inflacion(10,30),nuevosPuestosDeTrabajo(800000))).
promesa(amarillo(inflacion(1,15),aConstruir([(100,hospitales),(1,universidad),(200,comisarias)]),nuevosPuestosDeTrabajo(10000))).






