/*
Borrowed from a friend, only for testing with graphical view of the board.
*/


/*
 Takes the list of a board and constructs
 a list of a elements for all coordinates.
 */
buildcomplete(_,[],[]).
buildcomplete(Board,[(X,Y)|SB],[x|Map]):-
      member((black,X,Y),Board),
      buildcomplete(Board,SB,Map).
buildcomplete(Board,[(X,Y)|SB],[o|Map]):-
      member((white,X,Y),Board),
      buildcomplete(Board,SB,Map).
buildcomplete(Board,[_|SB],[' '|Map]):-
      buildcomplete(Board,SB,Map).

 /*
 Used to.. you guessed it! Print the board!
 */
printBoard(Board):-
       writef('   %n %n %n %n %n %n %n %n\n',[a,b,c,d,e,f,g,h]),!,
       buildcomplete(Board,[(a,1),(b,1),(c,1),(d,1),(e,1),(f,1),(g,1),(h,1)],Map1),
       writef(' 1|%n|%n|%n|%n|%n|%n|%n|%n|1\n',Map1),
       buildcomplete(Board,[(a,2),(b,2),(c,2),(d,2),(e,2),(f,2),(g,2),(h,2)],Map2),
       writef(' 2|%n|%n|%n|%n|%n|%n|%n|%n|2\n',Map2),
       buildcomplete(Board,[(a,3),(b,3),(c,3),(d,3),(e,3),(f,3),(g,3),(h,3)],Map3),
       writef(' 3|%n|%n|%n|%n|%n|%n|%n|%n|3\n',Map3),
       buildcomplete(Board,[(a,4),(b,4),(c,4),(d,4),(e,4),(f,4),(g,4),(h,4)],Map4),
       writef(' 4|%n|%n|%n|%n|%n|%n|%n|%n|4\t',Map4),
       %valueof(black,Board,V),
       writef('Value: %q\n',[V]),
       buildcomplete(Board,[(a,5),(b,5),(c,5),(d,5),(e,5),(f,5),(g,5),(h,5)],Map5),
       writef(' 5|%n|%n|%n|%n|%n|%n|%n|%n|5\t',Map5),
       %scoreof(black,Board,V),
       writef('Score: %q\n',[0]),
       buildcomplete(Board,[(a,6),(b,6),(c,6),(d,6),(e,6),(f,6),(g,6),(h,6)],Map6),
       writef(' 6|%n|%n|%n|%n|%n|%n|%n|%n|6\n',Map6),
       buildcomplete(Board,[(a,7),(b,7),(c,7),(d,7),(e,7),(f,7),(g,7),(h,7)],Map7),
       writef(' 7|%n|%n|%n|%n|%n|%n|%n|%n|7\n',Map7),
       buildcomplete(Board,[(a,8),(b,8),(c,8),(d,8),(e,8),(f,8),(g,8),(h,8)],Map8),
       writef(' 8|%n|%n|%n|%n|%n|%n|%n|%n|8\n',Map8),
       writef('   %n %n %n %n %n %n %n %n\n\n',[a,b,c,d,e,f,g,h]).