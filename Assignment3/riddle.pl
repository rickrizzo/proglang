students(0, []) :- !.
students(N, [(_Club, _Genre, _Major, _Pizza, _Poster)|T]) :- N1 is N-1, students(N1, T).

student(1, [H|_], H) :- !.
student(N, [_|T], R) :- N1 is N-1, student(N1, T, R).

% The Architecture major occupies the office with the Ctrl+Alt+Del comic poster.
hint1([(_, _, architecture, _, ctrl_alt_delete)|_]).
hint1([_|T]) :- hint1(T).

% The CSE major belongs to the RPI Flying Club.
hint2([(rpi_flying_club, _, cse, _, _)|_]).
hint2([_|T]) :- hint2(T).

% The GS major reads Sci Fi.
hint3([(_, sci_fi, gs, _, _)|_]).
hint3([_|T]) :- hint3(T).

% The office with the Dilbert comic poster is on the left of the office with the Calvin and Hobbes comic poster.
hint4([(_, _, _, _, dilbert), (_, _, _, _, calvin_and_hobbes)|_]).
hint4([_|T]) :- hint4(T).

% The office with the Dilbert comic poster's occupant reads Fantasy.
hint5([(_, fantasy, _, _, dilbert)|_]).
hint5([_|T]) :- hint5(T).

% The student who eats Pepperoni pizza belongs to the RCOS club.
hint6([(rcos, _, _, pepperoni, _)|_]).
hint6([_|T]) :- hint6(T).

% The occupant of the office with the xkcd comic poster eats Cheese pizza.
hint7([(_, _, _, cheese, xkcd)|_]).
hint7([_|T]) :- hint7(T).

% The student occupying the office in the middle reads Fiction.
hint8(Students) :- student(3, Students, (_, fiction, _, _, _)).

% The CS major occupies the first office.
hint9(Students) :- student(1, Students, (_, _, cs, _, _)).

% The student who eats Buffalo Chicken pizza occupies the office next to the one who belongs to the R Gaming Alliance club.
hint10([(_, _, _, buffalo_chicken, _), (r_gaming_alliance, _, _, _, _)|_]).
hint10([(r_gaming_alliance, _, _, _, _), (_, _, _, buffalo_chicken, _)|_]).
hint10([_|T]) :- hint10(T).

% The student who belongs to the CS club occupies the office next to the student who eats Cheese pizza.
hint11([(cs_club, _, _, _, _), (_, _, _, cheese, _)|_]).
hint11([(_, _, _, cheese, _), (cs_club, _, _, _, _)|_]).
hint11([_|T]) :- hint11(T).

% The student who eats Hawaiian pizza reads Poetry.
hint12([(_, poetry, _, hawaiian, _)|_]).
hint12([_|T]) :- hint12(T).

% The ITWS major eats Broccoli pizza.
hint13([(_, _, itws, broccoli, _)|_]).
hint13([_|T]) :- hint13(T).

% The CS major occupies the office next to the one with the PHD Comics comic poster.
hint14([(_, _, cs, _, _), (_, _, _, _, phd_comics)|_]).
hint14([(_, _, _, _, phd_comics), (_, _, cs, _, _)|_]).
hint14([_|T]) :- hint14(T).

% The student who eats Buffalo Chicken pizza has an office neighbor who reads History.
hint15([(_, _, _, buffalo_chicken, _), (_, history, _, _, _)|_]).
hint15([(_, history, _, _, _), (_, _, _, buffalo_chicken, _)|_]).
hint15([_|T]) :- hint15(T).

question([(taekwondo, _, _, _, _)|_]).
question([_|T]) :- question(T).

solution(Students) :-
  students(5, Students),
  hint1(Students),
  hint2(Students),
  hint3(Students),
  hint4(Students),
  hint5(Students),
  hint6(Students),
  hint7(Students),
  hint8(Students),
  hint9(Students),
  hint10(Students),
  hint11(Students),
  hint12(Students),
  hint13(Students),
  hint14(Students),
  hint15(Students),
  question(Students).
