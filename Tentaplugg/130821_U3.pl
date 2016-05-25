count(E, L, N):-
	countH(E, L, start, N),!.

countH(_, [], TempN,  TempN).

countH(E, L, start, N):-
	countH(E, L, 0, N).

countH(E, [E|L], TempN, N):-
	N1 is TempN+1,
	countH(E, L, N1, N).
countH(E, [E1|L], TempN, N):-
	E \= E1, 
	countH(E, L, TempN, N).
