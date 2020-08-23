herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

% 1
% tieneHerramienta(Quien, Herramienta)/2
tieneHerramienta(egon, aspiradora(200)).
tieneHerramienta(egon, trapeador).
tieneHerramienta(egon, sopapa).
tieneHerramienta(peter, trapeador).
tieneHerramienta(winston, varitaDeNeutrones).

% 2
% tieneHerramientaRequerida(Quien, Herramienta)/2
tieneHerramientaRequerida(Quien, Herramienta) :-
    tieneHerramienta(Quien, Herramienta).
tieneHerramientaRequerida(Quien, aspiradora(Potencia)) :-
    tieneHerramienta(Quien, aspiradora(PotenciaQuePosee)),
    Potencia =< PotenciaQuePosee.

% 3
% Se interpreta que puede hacer cualquier tarea dentro de las tareas existentes
% puedeRealizarTarea(Tarea, Quien)/2
puedeRealizarTarea(Tarea, Quien) :-
    herramientasRequeridas(Tarea, _),
    tieneHerramienta(Quien, varitaDeNeutrones).
puedeRealizarTarea(Tarea, Quien) :-
    tieneHerramienta(Quien, _),
    herramientasRequeridas(Tarea, HerraminetasNecesarias),
    tieneTodasLasHerramientas(HerraminetasNecesarias, Quien).

% tieneTodasLasHerramientas(HerramientasNecesarias, Quien)/2
tieneTodasLasHerramientas(HerramientasNecesarias, Quien) :-
    not((member(UnaHerramienta, HerramientasNecesarias), 
    not(tieneHerramientaRequerida(Quien, UnaHerramienta)))).

% 4
% Entonces lo que se le cobraría al cliente sería la suma del valor a cobrar por cada tarea, 
% multiplicando el precio por los metros cuadrados de la tarea.

% tareaPedida(Cliente, Tarea, Metros)/3
tareaPedida(_, _, _).
% precio(Tarea, PrecioPorMetro)/2
precio(_, _).


% pedido(Cliente, Costo)/2
pedido(Cliente, Costo) :-
    findall(Precio, 
        (tareaPedida(Cliente, Tarea, Metros), precio(tarea, PrecioPorMetro), Precio is PrecioPorMetro * Metros), 
        CostosTareas),
    sumlist(CostosTareas, Costo).