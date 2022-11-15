interpret_str("Tak", 1).
interpret_str("Nie", 0).

interpret_str("1", 10).
interpret_str("2", 11).
interpret_str("3", 12).
interpret_str("4", 13).
interpret_str("5", 14).
interpret_str("6", 15).

ask_number(Ans, Lower, Upper) :- 
    read(Number),
    between(Ans, Lower, Upper, Number).

between(Ans, Lower, Upper, Value) :-
    (Value < Lower -> interpret_str("1", Ans));
    (Value > Upper -> interpret_str("3", Ans));
    interpret_str("2", Ans).

ask_str(Ret) :-
    write("\nPodaj prawidlowa odpowiedz:\n"),
    current_input(Input),
    read_string(Input, "\n", "\r", _, Ans),
    interpret_str(Ans, Ret).
