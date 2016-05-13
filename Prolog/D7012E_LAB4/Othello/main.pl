:- [printBoard, legalMove, checkLegalMove, computeAdjacent].
%%%%%%%%%%%% OLD FILE %%%%%%%%%%%%%%%

%Start = [(white,d,4),(black,e,4),(black,d,5),(white,e,5)]
%Test = [(white,c,3),(white,d,3),(white,e,3),(white,e,4),(white,e,5),(white,d,5),(white,c,5),(white,c,4),(black, d,2),(black, f,4), (black,d,6), (black, b,4), (black,b,2), (black,f,2),(black,f,6),(black,b,6)]

print():-
	printBoard([(white,c,3),(white,d,3),(white,e,3),(white,e,4),(white,e,5),(white,d,5),(white,c,5),(white,c,4),(black, d,2),(black, f,4), (black,d,6), (black, b,4), (black,b,2), (black,f,2),(black,f,6),(black,b,6)]), !.