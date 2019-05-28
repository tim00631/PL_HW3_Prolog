ancestor(A, B) :-
    parent(A, B) % A is a parent of B.
    ;            % or
    (
    parent(A, X), % A is a parent of X AND X is a ancestor of B.
    ancestor(X, B)
    ).

lca(A, B) :-
    A == B  
    ->  writeln(A) % if A == B , A is lca(A,B).
    ;              % or
    ancestor(A, B) % if A is an ancestor of B,
    ->  writeln(A) % A is lca(A,B).
    ;   parent(X, A), % or X is a parent of A, and
        lca(X, B). % find lca(A's parent X, B).

pop(Z, L) :-
    L=[Z|_]. % Z = the first element of List L.

insert(N) :-
    N>0
    ->  readln(List),
        pop(V1, List),
        last(List, V2), % get the last element of List L.
        assert(parent(V1, V2)), % add a fact, parent(V1,V2).
        insert(N-1) % looping, until N is 0.
    ;   
    readln([M|_]), % read a number M to know how many queries the user want.
    query(M). % go go query.

query(M) :-
    M>0
    ->  readln(List2),
        pop(P1, List2), 
        last(List2, P2), % get the last element of List L.
        lca(P1, P2), % lca check
        query(M-1) % looping, until M is 0.
    ; halt.  
    
main :-
    writeln("Input:"),
    readln([N|_]), % read a number N to know how many relations to add.
    insert(N).

:- initialization (main).
