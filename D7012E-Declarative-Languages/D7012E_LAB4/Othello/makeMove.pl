:- [printBoard, legalMove].

%makemove(black, [(white,c,3),(white,d,3),(white,e,3),(white,e,4),(white,e,5),(white,d,5),(white,c,5),(white,c,4),(black, d,2),(black, f,4), (black,d,6), (black, b,4), (black,b,2), (black,f,2),(black,f,6),(black,b,6)], d, 4, NewBoard).
makemove(Color, Board, X, Y, [(Color, X, Y)|NewBoard]):-
	%printBoard(Board),
	legalmove(Color, Board, X, Y), 
	getBricks((Color, X, Y), Board, AllBricks), 
	flipMain(AllBricks, Board, NewBoard), !.
	%printBoard(NewBoard), !.

getBricks((C, X, Y), Board, AllBricks):-
	checkCloseBricks(C, Board, X, Y, StartBricks),!,
	findall(BrickSet, startChain(C, Board, StartBricks, BrickSet), Bricks), 
	flatten(Bricks, AllBricks).


flipMain(FlipBricks, [(C, X1, Y1)|Board], [Brick|NewBoard]):-
	flipBrick(FlipBricks, (C, X1, Y1), Brick), 
	flipMain(FlipBricks, Board, NewBoard).

flipMain(_, [], []).

flipBrick([(C, X1, Y1)|_], (C1, X1, Y1), (C2, X1, Y1)):-
	C == C1,
	changeColor(C1, C2).

flipBrick([_|FlipBricks], (C1, X2, Y2), Brick):-
	flipBrick(FlipBricks, (C1, X2, Y2), Brick).

flipBrick([], Brick, Brick).