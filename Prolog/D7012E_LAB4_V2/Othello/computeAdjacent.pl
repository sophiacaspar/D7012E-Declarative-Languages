%! right
adjacent(X1, X2, Y, Y, right):-
	findRight(X1, X2).

%! left
adjacent(X1, X2, Y, Y, left):-
	findLeft(X1, X2).

%! up
adjacent(X, X, Y1, Y2, up):-
	findUp(Y1, Y2).

%! down
adjacent(X, X, Y1, Y2, down):-
	findDown(Y1, Y2).

%! left-up
adjacent(X1, X2, Y1, Y2, leftUp):-
	findLeftUp(X1, X2, Y1, Y2).

%! right-up
adjacent(X1, X2, Y1, Y2, rightUp):-
	findRightUp(X1, X2, Y1, Y2).

%! left-down
adjacent(X1, X2, Y1, Y2, leftDown):-
	findLeftDown(X1, X2, Y1, Y2).

%! right-down
adjacent(X1, X2, Y1, Y2, rightDown):-
	findRightDown(X1, X2, Y1, Y2).



findRight(X1, X2):-
	char_code(X1, ValueX1),
	char_code(X2, ValueX2),
	X1Sum is (ValueX1 + 1),
	X1Sum == ValueX2.
getRight(X1, X2):-
	char_code(X1, ValueX1),
	X1Sum is (ValueX1 + 1),
	char_code(X2, X1Sum).
	

findLeft(X1, X2):-
	char_code(X1, ValueX1),
	char_code(X2, ValueX2),
	X1Sum is (ValueX1 - 1),
	X1Sum == ValueX2.
getLeft(X1, X2):-
	char_code(X1, ValueX1),
	X1Sum is (ValueX1 - 1),
	char_code(X2, X1Sum).


findUp(Y1, Y2):-
	Y1Sum is (Y1 - 1),
	Y1Sum == Y2.
getUp(Y1, Y2):-
	Y2 is (Y1 - 1).


findDown(Y1, Y2):-
	Y1Sum is (Y1 + 1),
	Y1Sum == Y2.
getDown(Y1, Y2):-
	Y2 is (Y1 + 1).


findLeftUp(X1, X2, Y1, Y2):-
	findLeft(X1, X2),
	findUp(Y1, Y2).
getLeftUp(X1, X2, Y1, Y2):-
	getLeft(X1, X2),
	getUp(Y1, Y2).


findRightUp(X1, X2, Y1, Y2):-
	findRight(X1, X2),
	findUp(Y1, Y2).
getRightUp(X1, X2, Y1, Y2):-
	getRight(X1, X2),
	getUp(Y1, Y2).


findLeftDown(X1, X2, Y1, Y2):-
	findLeft(X1, X2),
	findDown(Y1, Y2).
getLeftDown(X1, X2, Y1, Y2):-
	getLeft(X1, X2),
	getDown(Y1, Y2).


findRightDown(X1, X2, Y1, Y2):-
	findRight(X1, X2),
	findDown(Y1, Y2).
getRightDown(X1, X2, Y1, Y2):-
	getRight(X1, X2),
	getDown(Y1, Y2).
