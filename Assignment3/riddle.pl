% Helper Relationships
next(A, B, Ls) :- append(_, [A,B|_], Ls).
next(A, B, Ls) :- append(_, [B,A|_], Ls).

left(A, B, Ls) :- append(_, [A,B|_], Ls).

offices(Offices) :-
  length(Offices, 5),
  % The Architecture major occupies the office with the Ctrl+Alt+Del comic poster.
  member(s(_, _, architecture, _, ctrl_alt_delete), Offices),
  % The CSE major belongs to the RPI Flying Club.
  member(s(rpi_flying_club, _, cse, _, _), Offices),
  % The GS major reads Sci Fi.
  member(s(_, sci_fi, gs, _, _), Offices),
  % The office with the Dilbert comic poster is on the left of the office with the Calvin and Hobbes comic poster.
  left(s(_, _, _, _, dilbert), s(_, _, _, _, calvin_and_hobbes), Offices),
  % The office with the Dilbert comic poster's occupant reads Fantasy.
  member(s(_, fantasy, _, _, dilbert), Offices),
  % The student who eats Pepperoni pizza belongs to the RCOS club.
  member(s(rcos, _, _, pepperoni, _), Offices),
  % The occupant of the office with the xkcd comic poster eats Cheese pizza.
  member(s(_, _, _, cheese, xkcd), Offices),
  % The student occupying the office in the middle reads Fiction.
  Offices = [_, _, s(_, fiction, _, _, _), _, _],
  % The CS major occupies the first office.
  Offices = [s(_, _, cs, _, _)|_],
  % The student who eats Buffalo Chicken pizza occupies the office next to the one who belongs to the R Gaming Alliance club.
  next(s(_, _, _, buffalo_chicken, _), s(r_gaming_alliance, _, _, _, _), Offices),
  % The student who belongs to the CS club occupies the office next to the student who eats Cheese pizza.
  next(s(cs_club, _, _, _, _), s(_, _, _, cheese, _), Offices),
  % The student who eats Hawaiian pizza reads Poetry.
  member(s(_, poetry, _, hawaiian, _), Offices),
  % The ITWS major eats Broccoli pizza.
  member(s(_, _, itws, broccoli, _), Offices),
  % The CS major occupies the office next to the one with the PHD Comics comic poster.
  next(s(_, _, cs, _, _), s(_, _, _, _, phd_comics), Offices),
  % The student who eats Buffalo Chicken pizza has an office neighbor who reads History.
  next(s(_, _, _, buffalo_chicken, _), s(_, history, _, _, _), Offices).

student(Major) :-
  offices(Offices),
  member(s(taekwondo, _, Major, _, _), Offices).
