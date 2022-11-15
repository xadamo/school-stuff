:- consult('getyesno.pl').

start :-
   write('Ten program sprawdza stan roweru przed rozpoczeciem jazdy.'),nl,
   write('Odpowiedz na wszystkie pytania by dowiedziec sie czy mozesz rozpoczac jazde.'),nl,
   wyczysc_odpowiedzi,
   diagnozuj.

diagnozuj :-
   usterka(D),
   wyjasnienie(D),
   fail.

diagnozuj.

usterka(niesprawne_hamulce) :-
   user_says(starter_was_ok,yes),
   user_says(starter_is_ok,no).

usterka(brak_powietrza_w_oponach) :-
   user_says(starter_was_ok,no).

usterka(nienaoliwiony_lancuch) :-
   user_says(starter_was_ok,no).

usterka(brak_oswietlenia) :-
   user_says(starter_was_ok,yes),
   user_says(fuel_is_ok,no).

usterka(brak_dzwonka) :-
   user_says(starter_was_ok,yes),
   user_says(fuel_is_ok,yes).

usterka(luzne_dzwignie) :-
   user_says(starter_was_ok,yes),
   user_says(fuel_is_ok,yes).

usterka(zuzyty_bieznik) :-
   user_says(starter_was_ok,yes),
   user_says(fuel_is_ok,yes).

:- dynamic(zapisana_odpowiedz/2).
wyczysc_odpowiedzi :- retract(zapisana_odpowiedz(_,_)), fail.
wyczysc_odpowiedzi.


user_says(Q,A) :- zapisana_odpowiedz(Q,A).

user_says(Q,A) :- \+ zapisana_odpowiedz(Q,_),
                  nl,nl,
                  zadaj_pytanie(Q),
                  get_yes_or_no(Response),
                  asserta(zapisana_odpowiedz(Q,Response)),
                  Response = A.

zadaj_pytanie(hamulce) :-
   write('Czy zaciski hamulcowe reaguja wcisniecie dzwigini hamulcowych?,'),nl,
   write('Jesli reaguja tylko '),nl.

zadaj_pytanie(starter_is_ok) :-
   write('Does the starter crank the engine normally now? '),nl.

zadaj_pytanie(fuel_is_ok) :-
   write('Look in the carburetor.  Can you see or smell gasoline?'),nl.

wyjasnienie(wrong_gear) :-
   nl,
   write('Check that the gearshift is set to Park or Neutral.'),nl,
   write('Try jiggling the gearshift lever.'),nl.

wyjasnienie(starting_system) :-
   nl,
   write('Check for a defective battery, voltage'),nl,
   write('regulator, or alternator; if any of these is'),nl,
   write('the problem, charging the battery or jump-'),nl,
   write('starting may get the car going temporarily.'),nl,
   write('Or the starter itself may be defective.'),nl.

wyjasnienie(drained_battery) :-
   nl,
   write('Your attempts to start the car have run down the battery.'),nl,
   write('Recharging or jump-starting will be necessary.'),nl,
   write('But there is probably nothing wrong with the battery itself.'),nl.

wyjasnienie(fuel_system) :-
   nl,
   write('Check whether there is fuel in the tank.'),nl,
   write('If so, check for a clogged fuel line or filter'),nl,
   write('or a defective fuel pump.'),nl.

wyjasnienie(ignition_system) :-
   nl,
   write('Check the spark plugs, cables, distributor,'),nl,
   write('coil, and other parts of the ignition system.'),nl,
   write('If any of these are visibly defective or long'),nl,
   write('overdue for replacement, replace them; if this'),nl,
   write('does not solve the problem, consult a mechanic.'),nl.
