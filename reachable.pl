isconnected(A, B) :-
        edge(A, B) -> writeln('Yes')  % if A,B has edge, output Yes. 
        ;
        edge(B, A) -> writeln('Yes') % if A,B has edge, output Yes. 
        ;
        edge(A, X), % if A,X has edge and X can walk to B, output Yes. 
        walk(X, B,[]) -> writeln('Yes')
        ;
        edge(B, X), % if B,X has edge and X can walk to A, output Yes. 
        walk(X, A,[]) -> writeln('Yes')
        ; writeln('No'). % there is no path between A and B.
    
walk(A, B, Path) :-
    edge(A, X),             % if A has edge to X, and
    \+ memberchk(X, Path),  % X is not visited, and
    (B = X                  % (B is X or X can walk to B).
    ;walk(X, B, [A|Path])   % Add A to Path.
    ).

pop(Z, L) :-
    L=[Z|_]. % get the first element of List L.

% insert is the same of lca.pl -> insert(N)
insert(E):-
    E>0
    ->  readln(List),
        pop(V1, List),
        last(List, V2),
        assert(edge(V1, V2)),
        insert(E-1)
    ;
    readln([M|_]),
    query(M).

% query is the same of lca.pl -> query(M)
query(M):-
    M>0
    ->  readln(List2),
        pop(P1, List2),
        last(List2, P2),
        isconnected(P1, P2),
        query(M-1)
    ; halt.
main :-
    writeln('input'),
    readln(L), 
    pop(N,L), % read a number N to know how many nodes to add.
    last(L,E), % read a number E to know how many edges to add.
    N > 1
    ->insert(E)
    ; main.

:- initialization (main).

