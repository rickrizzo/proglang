% Grammer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
club(rpi_flying).

major(itws).
major(cs).
major(cse).
major(gs).
major(architecture).

genre(fiction).
genre(fantasy).
genre(sci_fi).
genre(history).
genre(poetry).

pizza(cheese).
pizza(pepperoni).

poster(ctrl_alt_del).
poster(dilbert).
poster(calvin_and_hobbes).

leftposition(left).

% Helper Functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
atom_to_list(Stream, Line) :-
  read_line_to_codes(Stream, FCs),
  atom_codes(FA, FCs),
  atomic_list_concat(Line, ' ', FA).

next(A, B, Ls) :- append(_, [A,B|_], Ls).
next(A, B, Ls) :- append(_, [B,A|_], Ls).

left(A, B, Ls) :- append(_, [A,B|_], Ls).

sentence(Line, Offices) :-
  member(Position, Line),
  leftposition(Position),
  member(Poster1, Line),
  poster(Poster1),
  member(Poster2, Line),
  poster(Poster2),
  Poster1 \== Poster2,
  left(s(_, _, _, _, Poster1), s(_, _, _, _, Poster2), Offices).

sentence(Line, Offices) :-
  member(Major, Line),
  major(Major),
  member(Poster, Line),
  poster(Poster),
  member(s(_, _, Major, _, Poster), Offices).

sentence(Line, Offices) :-
  member(Major, Line),
  major(Major),
  member(Club, Line),
  club(Club),
  member(s(Club, _, Major, _, _), Offices).

sentence(Line, Offices) :-
  member(Major, Line),
  major(Major),
  member(Genre, Line),
  genre(Genre),
  member(s(_, Genre, Major, _, _), Offices).

sentence(Line, Offices) :-
  member(Poster, Line),
  poster(Poster),
  member(Genre, Line),
  genre(Genre),
  member(s(_, Genre, _, _, Poster), Offices).


% Main
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
generateRiddle(File) :-
  length(Offices, 5),
  open(File, read, Stream),

  % Hint 1
  atom_to_list(Stream, Line1),
  sentence(Line1, Offices),

  % Hint 2
  atom_to_list(Stream, Line2),
  sentence(Line2, Offices),

  % Hint 3
  atom_to_list(Stream, Line3),
  sentence(Line3, Offices),

  % Hint 4
  atom_to_list(Stream, Line4),
  sentence(Line4, Offices),

  % Hint 5
  atom_to_list(Stream, Line5),
  write(Line5), nl,
  sentence(Line5, Offices),

  write(Offices), nl.

% sentence(Major, Offices) :-
%   read_line(Line),
%   member(Major, Line),
%   major(Major),
%   member(Genre, Line),
%   genre(Genre),
%   member(s(_, Genre, Major, _, _), Offices).
%
% sentence(Major, Offices) :-
%   read_line(Line),
%   member(Major, Line),
%   major(Major),
%   member(Pizza, Line),
%   pizza(Pizza),
%   member(s(_, _, Major, Pizza, _), Offices).
