
%makemove(black, [(white,c,3),(white,d,3),(white,e,3),(white,e,4),(white,e,5),(white,d,5),(white,c,5),(white,c,4),(black, d,2),(black, f,4), (black,d,6), (black, b,4), (black,b,2), (black,f,2),(black,f,6),(black,b,6)], d, 4, NewBoard).

/*
makemove places a brick on board and then flips nearby bricks according to
othello rules.
*/
makemove(Color, Board, X, Y, [(Color, X, Y)|NewBoard]):-
	validInput(Color, X, Y, Board),!,
	legalmove(Color, Board, X, Y),
	getBricks((Color, X, Y), Board, AllBricks), 
	flipMain(AllBricks, Board, NewBoard).

/*
Gets all bricks that are close to the placed brick,
these are the startbricks which we start checking chains from.
The bricks with valid chains are returned and then fliped.
*/
getBricks((C, X, Y), Board, AllBricks):-
	checkCloseBricks(C, Board, X, Y, StartBricks),!,
	findall(BrickSet, startChain(C, Board, StartBricks, BrickSet), Bricks), 
	flatten(Bricks, AllBricks).

/*
Goes through all wanted bricks and changes color on them. 
Returns the newboard after flipping.
*/
flipMain(FlipBricks, [(C, X1, Y1)|Board], [Brick|NewBoard]):-
	flipBrick(FlipBricks, (C, X1, Y1), Brick), 
	flipMain(FlipBricks, Board, NewBoard),!.

flipMain(_, [], []).

flipBrick([(C, X1, Y1)|_], (C1, X1, Y1), (C2, X1, Y1)):-
	C == C1,
	changeColor(C1, C2).

flipBrick([_|FlipBricks], (C1, X2, Y2), Brick):-
	flipBrick(FlipBricks, (C1, X2, Y2), Brick).

flipBrick([], Brick, Brick).


/*
Takes startbricks to start checking for valid chains.
Valid chain should have a brick with the other color placed last.
XXXXO for example.
*/
startChain(_, _, [], []).	

startChain(C1, Board, [(X, Y, Dir)|_], NextBrick):-
	changeColor(C1, C2),
	checkMain((C2, X, Y), Board, NextBrick, Dir).

startChain(C1,Board, [_|StartBricks], Legal):-
	startChain(C1, Board, StartBricks, Legal).

/*
Checks for chains. If brick is the same color, then continue the search,
if brick has opposite color, add chain to list.
*/
checkMain((C, X1, Y1), Board, [(C, X1, Y1)|NextBrick], Dir):-
	checkChain((C, X1, Y1), Board, (C1, X2, Y2), Dir),
	C == C1,
	checkMain((C1, X2, Y2), Board, NextBrick, Dir).

checkMain((C, X1, Y1), Board, [(C, X1, Y1)], Dir):-
	checkChain((C, X1, Y1), Board, (C1, _, _), Dir),
	C \= C1.

checkMain((_, _, _), [], [], _).


/*
Checks for valid chains in each direction.
Returns chain.
*/

% right
checkChain((C, X1, Y), [(C, X2, Y) | _], Chain, right):-
	findRight(X1, X2),
	Chain = (C, X2, Y).
checkChain((C1, X1, Y), [(C2, X2, Y)| _], (C2, X2, Y), right) :-
	C1 \= C2,
	findRight(X1, X2).

% left
checkChain((C, X1, Y), [(C, X2, Y) | _], Chain, left):-
	findLeft(X1, X2),
	Chain = (C, X2, Y).
checkChain((C1, X1, Y), [(C2, X2, Y)| _], (C2, X2, Y), left) :-
	C1 \= C2,
	findLeft(X1, X2).

% up
checkChain((C, X, Y1), [(C, X, Y2) | _], Chain, up):-
	findUp(Y1, Y2),
	Chain = (C, X, Y2).
checkChain((C1, X, Y1), [(C2, X, Y2)| _], (C2, X, Y2), up) :-
	C1 \= C2,
	findUp(Y1, Y2).

% down
checkChain((C, X, Y1), [(C, X, Y2) | _], Chain, down):-
	findDown(Y1, Y2),
	Chain = (C, X, Y2).
checkChain((C1, X, Y1), [(C2, X, Y2)| _], (C2, X, Y2), down) :-
	C1 \= C2,
	findDown(Y1, Y2).

% left-up
checkChain((C, X1, Y1), [(C, X2, Y2) | _], Chain, leftUp):-
	findLeftUp(X1, X2, Y1, Y2),
	Chain = (C, X2, Y2).
checkChain((C1, X1, Y1), [(C2, X2, Y2)| _], (C2, X2, Y2), leftUp) :-
	C1 \= C2,
	findLeftUp(X1, X2, Y1, Y2).	

% right-up
checkChain((C, X1, Y1), [(C, X2, Y2) | _], Chain, rightUp):-
	findRightUp(X1, X2, Y1, Y2),
	Chain = (C, X2, Y2).
checkChain((C1, X1, Y1), [(C2, X2, Y2)| _], (C2, X2, Y2), rightUp) :-
	C1 \= C2,
	findRightUp(X1, X2, Y1, Y2).

% left-down
checkChain((C, X1, Y1), [(C, X2, Y2) | _], Chain, leftDown):-
	findLeftDown(X1, X2, Y1, Y2),
	Chain = (C, X2, Y2).
checkChain((C1, X1, Y1), [(C2, X2, Y2)| _], (C2, X2, Y2), leftDown) :-
	C1 \= C2,
	findLeftDown(X1, X2, Y1, Y2).

% right-down
checkChain((C, X1, Y1), [(C, X2, Y2) | _], Chain, rightDown):-
	findRightDown(X1, X2, Y1, Y2),
	Chain = (C, X2, Y2).
checkChain((C1, X1, Y1), [(C2, X2, Y2)| _], (C2, X2, Y2), rightDown) :-
	C1 \= C2,
	findRightDown(X1, X2, Y1, Y2).

checkChain((C1, X1, Y1), [(_, _, _)|Board], Trace, Dir) :-
	checkChain((C1, X1, Y1), Board, Trace, Dir).
