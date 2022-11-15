wypisz([]).

wypisz([Head | Tail]) :-
    print(Head), nl,
    wypisz(Tail).

wypisz_inv([Head | Tail]) :-
    wypisz_inv(Tail),
    print(Head),
    nl.
wypisz_inv([]).
