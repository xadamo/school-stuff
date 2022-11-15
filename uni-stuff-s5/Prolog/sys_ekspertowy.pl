% pytania:
% czy jest słonecznie - Y:
%   czy jest sucho czy wilgotno

:- consult('realYesNo.pl').

begin :- 
    write('Ten program pomoze Ci\nwybrac odpowiednie ubranie\ndo pogody na zewnatrz\n'),
    clearAns,
    lookThrough.


lookThrough :- 
    findall(A, findClothing(A), D),
    write("Mozesz dzisiaj ubrac na siebie: \n"),
    findall(D, explain(D), X),
    maplist(explain(X), X),
    write(D).
    % findClothing(A),
    % explain(A).


:- dynamic(answers/2).
% :- dynamic()


clearAns :- retract(answers(_,_)),fail.
clearAns.

% konwertuj pytania z realYesNo.pl
askYNQuestion(Q, A) :- answers(Q, A).

askYNQuestion(Q, A) :- \+ answers(Q, _),
    nl,
    ask(Q),
    ask_str(Resp),
    asserta(answers(Q, Resp)),
    Resp = A.


askTempQuestion(Q, A) :- answers(Q, A).

askTempQuestion(Q, Down, Up, A) :- \+ answers(Q, _),
    nl,
    ask(Q),
    ask_number(Resp, Down, Up),
    asserta(answers(Q, Resp)),
    Resp = A.





% baza wiedzy

findClothing(parasol) :-
    askYNQuestion(slonecznie, 0);
    askYNQuestion(slonecznie, 1),
    askYNQuestion(sucho, 1),
    askYNQuestion(sucho, 0),
    askYNQuestion(wiatr, 1),
    (
        askYNQuestion(wiatrSila, 11);
        askYNQuestion(wiatrSila, 12);
        askYNQuestion(wiatrSila, 13)    
    );
    askYNQuestion(wiatr, 0),
    askYNQuestion(opady, 1),
    (
        askYNQuestion(opadyRodzaj, 12);
        askYNQuestion(opadyRodzaj, 13);
        askYNQuestion(opadyRodzaj, 14);
        askYNQuestion(opadyRodzaj, 15);
        askYNQuestion(opadyRodzaj, 16)    
    );
    askYNQuestion(opady, 0),
    askTempQuestion(temperatura, 8, 30, 11).

findClothing(koszulka) :-
    askYNQuestion(sucho, 1),
    askYNQuestion(slonecznie, 1),
    askTempQuestion(temperatura, 10, 20, 11).

findClothing(buty_sportowe) :-
    askYNQuestion(slonecznie, 1),
    askYNQuestion(sucho, 1),
    askYNQuestion(opady, 1),
    (
        askYNQuestion(opadyRodzaj, 11);
        askYNQuestion(opadyRodzaj, 12);
        askYNQuestion(opadyRodzaj, 13)
    );
    askYNQuestion(opady, 0).
    

findClothing(krotkie_spodenki) :-
    askYNQuestion(slonecznie, 1),
    askYNQuestion(sucho, 1),
    askYNQuestion(opady, 0),
    askTempQuestion(temperatura, 15, 20, 11).

findClothing(dlugie_spodnie) :-
    askYNQuestion(sucho, 0),
    askTempQuestion(temperatura, 0, 14, 11).

findClothing(bluza) :-
    askYNQuestion(opady, 0);
    askYNQuestion(opady, 1),
    (
        askYNQuestion(opadyRodzaj, 11);
        askYNQuestion(opadyRodzaj, 12);
        askYNQuestion(opadyRodzaj, 13)
    ),
    askTempQuestion(temperatura, 3, 12, 11).

findClothing(buty_z_holweka) :-
    askYNQuestion(sucho, 0),
    askYNQuestion(opady, 0);
    askYNQuestion(opady, 1),
    (
        askYNQuestion(opadyRodzaj, 13);
        askYNQuestion(opadyRodzaj, 14);
        askYNQuestion(opadyRodzaj, 15);
        askYNQuestion(opadyRodzaj, 16)
    ).

findClothing(koszulka_z_dlugimi_rekawami) :-
    askYNQuestion(slonecznie, 1),
    askYNQuestion(sucho, 1),
    askYNQuestion(opady, 0),
    askYNQuestion(wiatr, 0),
    askTempQuestion(temperatura, 10, 20, 11).

findClothing(koszula) :-
    askYNQuestion(slonecznie, 1),
    askYNQuestion(sucho, 1),
    askYNQuestion(opady, 0),
    askYNQuestion(wiatr, 0),
    askTempQuestion(temperatura, 10, 20, 11).

findClothing(kadrigan) :-
    askYNQuestion(sucho, 1),
    askYNQuestion(opady, 0),
    askYNQuestion(wiatr, 0),
    askTempQuestion(temperatura, 5, 15, 11).

findClothing(sweter) :-
    askTempQuestion(temperatura, 0, 12, 11).

findClothing(plaszcz) :-
    askYNQuestion(sucho, 0),
    askYNQuestion(opady, 0);
    askYNQuestion(opady, 1),
    (
        askYNQuestion(opadyRodzaj, 11);
        askYNQuestion(opadyRodzaj, 12);
        askYNQuestion(opadyRodzaj, 13);
        askYNQuestion(opadyRodzaj, 14)   
    ),
    askTempQuestion(temperatura, -10, 12, 11).

findClothing(kurtka) :-
    askTempQuestion(temperatura, -10, 5, 11).

findClothing(czapka_zimowa) :-
    askYNQuestion(wiatr, 1),
    (
        askYNQuestion(wiatrSila, 12);
        askYNQuestion(wiatrSila, 13);
        askYNQuestion(wiatrSila, 14)    
    ),
    askTempQuestion(temperatura, -20, 0, 11).

findClothing(szalik) :-
    askYNQuestion(wiatr, 0);
    askYNQuestion(wiatr, 1),
    (
        askYNQuestion(wiatrSila, 12);
        askYNQuestion(wiatrSila, 13);
        askYNQuestion(wiatrSila, 14)    
    ),
    askTempQuestion(temperatura, -20, 5, 11).

findClothing(buty_zimowe) :-
    askYNQuestion(opady, 0);
    askYNQuestion(opady, 1),
    (
    askYNQuestion(opadyRodzaj, 14);
    askYNQuestion(opadyRodzaj, 15);
    askYNQuestion(opadyRodzaj, 16)    
    ),
    askTempQuestion(temperatura, -20, 5, 11).

findClothing(spodnie_zimowe) :-
    askTempQuestion(temperatura, -20, -1, 11).

findClothing(kalesony) :-
    askTempQuestion(temperatura, -20, -1, 11).

findClothing(kaszkietowka) :-
    askYNQuestion(sucho, 1),
    askYNQuestion(slonecznie, 1),
    askYNQuestion(wiatr, 0),
    askYNQuestion(opady, 0),
    askTempQuestion(temperatura, 8, 30, 11).

findClothing(kaszkiet) :-
    askYNQuestion(sucho, 1),
    askYNQuestion(slonecznie, 0),
    askYNQuestion(wiatr, 0),
    askYNQuestion(opady, 0),
    askTempQuestion(temperatura, 20, 30, 11).



%   pytania
% slonecznie czy sucho

ask(slonecznie) :-
    write('Czy na dworze jest slonecznie?').

ask(sucho) :-
    write('Czy na dworze jest sucho?').

% czy wieje wiatr i jak mocno

ask(wiatr) :-
    write('Czy na dworze wieje wiatr?').

ask(wiatrSila) :-
    write('Jak mocno wieje na dworze?\n1 - maly wiaterek\n2 - sredni wiater\n3 - mocny wicher\n4 - niebezpieczny wiatr').


% opady i jakie

ask(opady) :-
    write('Czy wystepuja opady?').

ask(opadyRodzaj) :-
    write('Jaki rodzaj opadow wystepuje?\n1 - zamglenie\n2 - mzawka\n3 - srednie opady deszczu\n4 - ulewa\n5 - snieg\n6 - grad').

% temperatura

ask(temperatura) :-
    write('Ile stopni jest na dworze?\nPodaj odpowiedz: ').

explain(parasol) :-
    write('Ubierz parasol .\n').

explain(buty_sportowe) :-
    write('Ubierz buty sportowe.\n').

explain(krotkie_spodenki) :-
    write('Ubierz spodenki .\n').