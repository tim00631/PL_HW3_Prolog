is_prime(2). % Return true.
is_prime(3). % Return true.
is_prime(P) :-
    P > 3,
    P mod 2 =\= 0, % P doesn't have factor "2" .
    \+ has_factor(P,3). % if P doesn't have odd factor which is >= 3, return true.

has_factor(N,L) :-
    N mod L =:= 0. % L is a factor of N.
has_factor(N,L) :- % L2 = L + 2, L2 is a factor of N.
    L * L < N,
    L2 is L+2,
    has_factor(N,L2).

gold(4,[2,2]) :- 
    !. % No backtracking.
gold(N, L) :-
    N mod 2 =:= 0, % N is even number.
    N > 4 
    -> gold(N, L, 3)
    ; 
    N =:= 4 % N is 4, special case
    -> writeln('2 2'),
        halt.
gold(N, [P, Q], P) :-
    Q is N-P,
    P < Q,
    is_prime(Q),
    write(P), % find a combination , print out to the screen
    write(" "),
    writeln(Q),
    fail.

gold(N, L, P) :- % Find next combination.
    P < N,
    next_prime(P, P1), % P1 is new prime number.
    gold(N, L, P1). % call back to line 21 predicate.
next_prime(P, P1) :- % show P's next valid prime number.
    P1 is P+2,
    is_prime(P1),
    !. % and no backtracking.
next_prime(P, P1) :- % (3,5)->(5,5)->(5,7)->(7,7) keep search possible prime combination.
    P2 is P+2,
    next_prime(P2, P1).
main :- %main function to read a positive even number.
    writeln("input:"),
    readln(Input),
    writeln("Output:"),
    gold(Input, L),
    L
    ; halt.

:-  initialization(main).
