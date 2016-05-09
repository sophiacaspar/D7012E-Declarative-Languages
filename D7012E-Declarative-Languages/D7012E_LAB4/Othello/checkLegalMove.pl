:- [computeAdjacent].



checkMain((C, X1, Y1), Board, [(C, X1, Y1)|NextBrick], Dir):-
	checkChain((C, X1, Y1), Board, (C1, X2, Y2), Dir),
	C == C1,
	checkMain((C1, X2, Y2), Board, NextBrick, Dir).

checkMain((C, X1, Y1), Board, [(C, X1, Y1)], Dir):-
	checkChain((C, X1, Y1), Board, (C1, X2, Y2), Dir),
	C \= C1.

checkMain((_, _, _), [], [], _).


%! right
checkChain((C, X1, Y), [(C, X2, Y) | _], Chain, right):-
	findRight(X1, X2),
	Chain = (C, X2, Y).
checkChain((C1, X1, Y), [(C2, X2, Y)| _], (C2, X2, Y), right) :-
	C1 \= C2,
	findRight(X1, X2).

%! left
checkChain((C, X1, Y), [(C, X2, Y) | _], Chain, left):-
	findLeft(X1, X2),
	Chain = (C, X2, Y).
checkChain((C1, X1, Y), [(C2, X2, Y)| _], (C2, X2, Y), left) :-
	C1 \= C2,
	findLeft(X1, X2).

%! up
checkChain((C, X, Y1), [(C, X, Y2) | _], Chain, up):-
	findUp(Y1, Y2),
	Chain = (C, X, Y2).
checkChain((C1, X, Y1), [(C2, X, Y2)| _], (C2, X, Y2), up) :-
	C1 \= C2,
	findUp(Y1, Y2).

%! down
checkChain((C, X, Y1), [(C, X, Y2) | _], Chain, down):-
	findDown(Y1, Y2),
	Chain = (C, X, Y2).
checkChain((C1, X, Y1), [(C2, X, Y2)| _], (C2, X, Y2), down) :-
	C1 \= C2,
	findDown(Y1, Y2).

%! left-up
checkChain((C, X1, Y1), [(C, X2, Y2) | _], Chain, leftUp):-
	findLeftUp(X1, X2, Y1, Y2),
	Chain = (C, X2, Y2).
checkChain((C1, X1, Y1), [(C2, X2, Y2)| _], (C2, X2, Y2), leftUp) :-
	C1 \= C2,
	findLeftUp(X1, X2, Y1, Y2).	

%! right-up
checkChain((C, X1, Y1), [(C, X2, Y2) | _], Chain, rightUp):-
	findRightUp(X1, X2, Y1, Y2),
	Chain = (C, X2, Y2).
checkChain((C1, X1, Y1), [(C2, X2, Y2)| _], (C2, X2, Y2), rightUp) :-
	C1 \= C2,
	findRightUp(X1, X2, Y1, Y2).

%! left-down
checkChain((C, X1, Y1), [(C, X2, Y2) | _], Chain, leftDown):-
	findLeftDown(X1, X2, Y1, Y2),
	Chain = (C, X2, Y2).
checkChain((C1, X1, Y1), [(C2, X2, Y2)| _], (C2, X2, Y2), leftDown) :-
	C1 \= C2,
	findLeftDown(X1, X2, Y1, Y2).

%! right-down
checkChain((C, X1, Y1), [(C, X2, Y2) | _], Chain, rightDown):-
	findRightDown(X1, X2, Y1, Y2),
	Chain = (C, X2, Y2).
checkChain((C1, X1, Y1), [(C2, X2, Y2)| _], (C2, X2, Y2), rightDown) :-
	C1 \= C2,
	findRightDown(X1, X2, Y1, Y2).

checkChain((C1, X1, Y1), [(_, _, _)|Board], Trace, Dir) :-
	checkChain((C1, X1, Y1), Board, Trace, Dir).



