start :-
   write('Ten program pomoze przygotowac Ci twoj rower przed jazda.'),nl,
   wyczysc_odpowiedzi,
   diagnozuj.

diagnozuj :-
   usterka(X),
   wyjasnienie(X),
   fail.

tak_nie(Result) :- write('Podaj prawidlowa odpowiedz,
                         T lub t - tak,
                         N lub n - nie'),nl,
                         get(Char),
                         get0(_),
                         interpret(Char,Result).

menu(Result) :- write("Wybierz odpowiedz z menu"),nl,
                      get(Code),
                      get0(_),
                      interpret(Code, Result).

num(Ans, Lower) :- write("\nPodaj liczbe:\n"),
    read(Number),
    przedzial(Ans, Lower, Number).

przedzial(Ans, Lower, Value) :-
   (Value < Lower -> interpret_str("7", Ans));
   interpret_str("8",Ans).

interpret_str("7",11).
interpret_str("8",12).
interpret(84,tak).
interpret(116,tak).
interpret(78,nie).
interpret(110,nie).
interpret(49,zadne).
interpret(50,przedni).
interpret(51,tylny).
interpret(52,oba).
interpret(56,detkowy).
interpret(57,bezdetkowy).



:- dynamic(zapisana_odpowiedz/2).
wyczysc_odpowiedzi :- retract(zapisana_odpowiedz(_,_)), fail.
wyczysc_odpowiedzi.


odpowiedz_menu(Q,A) :- zapisana_odpowiedz(Q,A).

odpowiedz_menu(Q,A) :- \+ zapisana_odpowiedz(Q,_),
                  nl,nl,
                  zadaj_pytanie(Q),
                  menu(Response),
                  asserta(zapisana_odpowiedz(Q,Response)),
                  Response = A.

odpowiedz_tak_nie(Q,A) :- zapisana_odpowiedz(Q,A).

odpowiedz_tak_nie(Q,A) :- \+ zapisana_odpowiedz(Q,_),
                  nl,nl,
                  zadaj_pytanie(Q),
                  tak_nie(Response),
                  asserta(zapisana_odpowiedz(Q,Response)),
                  Response = A.

odpowiedz_liczba(Q,A) :- zapisana_odpowiedz(Q,A).

odpowiedz_liczba(Q,L,A) :- \+ zapisana_odpowiedz(Q,_),
                  nl,nl,
                  zadaj_pytanie(Q),
                  num(Response,L),
                  asserta(zapisana_odpowiedz(Q,Response)),
                  Response = A.

usterka(hamulce) :-
   odpowiedz_menu(hamulce_zaciski,zadne).

usterka(lancuch_olej) :-
   odpowiedz_tak_nie(olej_lancuch,nie).

usterka(lancuch_piasty) :-
   odpowiedz_tak_nie(piasty, nie).

usterka(oswietlenie) :-
   odpowiedz_tak_nie(oswietlenie,nie).

usterka(dzwonek) :-
   odpowiedz_tak_nie(dzwonek,nie).

usterka(kierownica_korby) :-
   odpowiedz_tak_nie(mechanizm_korbowy, tak).

usterka(kierownica_linki) :-
   odpowiedz_tak_nie(linki_pancerze, tak).

usterka(amortyzatory_smary) :-
   odpowiedz_tak_nie(amortyzatory_smar, nie).

usterka(amortyzatory_regulowanie) :-
   odpowiedz_tak_nie(amortyzatory_regulacja, nie).

usterka(opony) :-
   (   odpowiedz_menu(rodzaj_opon,detkowy) -> odpowiedz_liczba(powietrze,10,11);
   odpowiedz_tak_nie(mleczko,nie)).

zadaj_pytanie(hamulce_zaciski) :-
   write('Czy zaciski hamulcowe reaguja na wcisniecie dzwigini hamulcowych?'),nl,
   write('zaden nie reaguje - 1'),nl,
   write('tylko przedni reaguje - 2'),nl,
   write('tylko tylny reaguje - 3'),nl,
   write('oba reaguja - 4'),nl.

zadaj_pytanie(rodzaj_opon) :-
   write('Czy korzystasz z systemu detkowego opon?'),nl,
   write('system detkowy - 8'),nl,
   write('system bezdetkowy - 9'),nl.


zadaj_pytanie(mleczko) :-
   write('Czy mleczko uszczelniajace opony jest swieze?'),nl.

zadaj_pytanie(mechanizm_korbowy) :-
   write('Czy glowka kierownicy oraz mechanizm korbowy ulegly poluzowaniu?'),nl.

zadaj_pytanie(amortyzatory_smar) :-
   write('Czy amortyzatory rowerowe sa poprawnie nasmarowane?'),nl.

zadaj_pytanie(amortyzatory_regulacja) :-
   write('Czy amortyzatory rowerowe sa wyregulowane adekwatnie do Twojej wagi?'),nl.

zadaj_pytanie(piasty) :-
   write('Czy piasty obracaja sie plynnie i nie maja zbednych luzow?'),nl.

zadaj_pytanie(linki_pancerze) :-
   write('Czy linki laczace przerzutki i hamulce mechaniczne z manetkami'),nl,
   write('sa rozciagniete badz naderwane?'),nl.

zadaj_pytanie(olej_lancuch) :-
    write('Czy lancuch jest dobrze naoliwiony?'),nl,
    write('Nie powininen on wydawac zadnych dzwiekow i poruszac sie plynnie'),nl.

zadaj_pytanie(oswietlenie) :-
   write('Czy rower posiada zarowno lampki odblaskowe z tylu, jak i z przodu?'),nl.


zadaj_pytanie(dzwonek) :-
    write('Czy rower posiada zamontowany sprawny dzwonek'),nl.

zadaj_pytanie(powietrze) :-
   write('Czy w oponach jest wystarczajaca ilosc powietrza?'),nl,
   write('Do sprawdzenia mozesz uzyc pompki ze wskaznikiem'),nl.


wyjasnienie(hamulce) :-
   nl,
   write('Sprawdz czy przewody hamulcowe sa poprawnie przymocowane do dzwigni oraz zaciskow.'),nl,
   write('W razie potrzeby podlacz je z powrotem.'),nl.

wyjasnienie(lancuch_olej) :-
   nl,
   write('Wraz z eksploatacja roweru nalezy monitorowac stan lancucha,'),nl,
   write('jesli wymaga on naoliwienia nalezy odwrocic rower kierownica do dolu,'),nl,
   write('a nastepnie rozprowadzic rownomiernie niewielka ilosc oleju'),nl,
   write('wprawiajac lancuch w ruch(poprzez pedalowanie).'),nl.

wyjasnienie(lancuch_piasty) :-
   nl,
   write('Dokrec piasty, by nie mialy zadnych luzow i plynnie sie obracaly'),nl.

wyjasnienie(opony) :-
   nl,
   write('W przypadku opon bezdetkowych mleczko nalezy uzupelnic, po 100-120ml na jedno kolo,'),nl,
   write('W przypadku opon detkowych powietrze nalezy uzupelnic za pomoca pompki lub kompresora').

wyjasnienie(oswietlenie) :-
   nl,
   write('Jesli brakuje oswietlenia, nalezy je dokupic.'),nl,
   write('Przednie swiatelko odblaskowe powinno byc biale, a tylnie - czerwone'),nl,
   write('Zaleca sie, choc nie jest to wymagane - zamontowanie swiatla'),nl,
   write('aktywnego, na przyklad dzialajacego na zasadzie dynamo'),nl.


wyjasnienie(dzwonek) :-
   nl,
   write('W razie braku dzwonka powinno sie go zalozyc, choc wystarczy'),nl,
   write('jakiekolwiek zrodlo dzwieku, niekoniecznie dzwonek'),nl.

wyjasnienie(kierownica_korby) :-
   nl,
   write('Nalezy dokrecic sruby i zaciski kierownicy,'),nl.

wyjasnienie(kierownica_linki) :-
   nl,
   write('Wymien naciagniete linki hamulcowe oraz pancerze od przerzutek'),nl.

wyjasnienie(amortyzatory_smary) :-
   nl,
   write('Nasmaruj amortyzatory specjalnym smarem,'),nl.

wyjasnienie(amortyzatory_regulowanie) :-
   nl,
   write('Wyreguluj amortyzatory adekwatnie do swojej wagi:'),nl,
   write('Cisnienie powinno wynosci tyle, ile Twoja waga w funtach,'),nl,
   write('1 kg = 2.20 funta'),nl.
