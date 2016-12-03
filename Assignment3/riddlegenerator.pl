% Programming Languages Assignment 3
% Robert Russo and Robert Rotering
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Libraries
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% use_module(library(lambda)).

% Grammer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
club(rpi_flying).
club(cs_club).
club(rcos).
club(r_gaming_alliance).
club(taekwondo).

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
pizza(hawaiian).
pizza(broccoli).
pizza(buffalo_chicken).

poster(ctrl_alt_del).
poster(dilbert).
poster(calvin_and_hobbes).
poster(phd_comics).
poster(xkcd).

firstposition(first).
leftposition(left).
middleposition(middle).
nextposition(next).
nextposition(neighbor).

% Helper Functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% String to List
stream_to_list(Stream, Line) :-
  read_line_to_codes(Stream, FCs),
  atom_codes(FA, FCs),
  atomic_list_concat(LineUpper, ' ', FA),
  maplist(downcase_atom, LineUpper, Line).

% Directions
next(A, B, Ls) :- append(_, [A,B|_], Ls).
next(A, B, Ls) :- append(_, [B,A|_], Ls).

left(A, B, Ls) :- append(_, [A,B|_], Ls).

% First
sentence(Line, Offices) :-
  member(Position, Line),
  firstposition(Position),
  member(Major, Line),
  major(Major),
  Offices = [s(_, _, Major, _, _)|_].

% Left
sentence(Line, Offices) :-
  member(Position, Line),
  leftposition(Position),
  member(Poster1, Line),
  poster(Poster1),
  member(Poster2, Line),
  poster(Poster2),
  Poster1 \== Poster2,
  left(s(_, _, _, _, Poster1), s(_, _, _, _, Poster2), Offices).

% Middle
sentence(Line, Offices) :-
  member(Position, Line),
  middleposition(Position),
  member(Genre, Line),
  genre(Genre),
  Offices = [_, _, s(_, Genre, _, _, _), _, _].

% Next Pizza Club
sentence(Line, Offices) :-
  member(Position, Line),
  nextposition(Position),
  member(Pizza, Line),
  pizza(Pizza),
  member(Club, Line),
  club(Club),
  next(s(_, _, _, Pizza, _), s(Club, _, _, _, _), Offices),
  member(Student, Offices), Student \== s(Club, _, _, Pizza, _).

% Next Major Poster
sentence(Line, Offices) :-
  member(Position, Line),
  nextposition(Position),
  member(Major, Line),
  major(Major),
  member(Poster, Line),
  poster(Poster),
  next(s(_, _, Major, _, _), s(_, _, _, _, Poster), Offices),
  member(Student, Offices), Student \== s(_, _, Major, _, Poster).

% Next Pizza Genre
sentence(Line, Offices) :-
  member(Position, Line),
  nextposition(Position),
  member(Pizza, Line),
  pizza(Pizza),
  member(Genre, Line),
  genre(Genre),
  next(s(_, _, _, Pizza, _), s(_, Genre, _, _, _), Offices),
  member(Student, Offices), Student \== s(_, Genre, _, Pizza, _).

% Major - Poster
sentence(Line, Offices) :-
  member(Major, Line),
  major(Major),
  member(Poster, Line),
  poster(Poster),
  member(s(_, _, Major, _, Poster), Offices).

% Major - Club
sentence(Line, Offices) :-
  member(Major, Line),
  major(Major),
  member(Club, Line),
  club(Club),
  member(s(Club, _, Major, _, _), Offices).

% Major - Genre
sentence(Line, Offices) :-
  member(Major, Line),
  major(Major),
  member(Genre, Line),
  genre(Genre),
  member(s(_, Genre, Major, _, _), Offices).

% Major - Pizza
sentence(Line, Offices) :-
  member(Major, Line),
  major(Major),
  member(Pizza, Line),
  pizza(Pizza),
  member(s(_, _, Major, Pizza, _), Offices).

% Poster - Genre
sentence(Line, Offices) :-
  member(Poster, Line),
  poster(Poster),
  member(Genre, Line),
  genre(Genre),
  member(s(_, Genre, _, _, Poster), Offices).

% Pizza - Club
sentence(Line, Offices) :-
  member(Pizza, Line),
  pizza(Pizza),
  member(Club, Line),
  club(Club),
  member(s(Club, _, _, Pizza, _), Offices).

% Poster - Pizza
sentence(Line, Offices) :-
  member(Poster, Line),
  poster(Poster),
  member(Pizza, Line),
  pizza(Pizza),
  member(s(_, _, _, Pizza, Poster), Offices).

% Pizza - Genre
sentence(Line, Offices) :-
  member(Pizza, Line),
  pizza(Pizza),
  member(Genre, Line),
  genre(Genre),
  member(s(_, Genre, _, Pizza, _), Offices).

% Main
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
generateRiddle(File) :-
  length(Offices, 5),
  open(File, read, Stream),

  stream_to_list(Stream, Line1),
  stream_to_list(Stream, Line2),
  stream_to_list(Stream, Line3),
  stream_to_list(Stream, Line4),
  stream_to_list(Stream, Line5),
  stream_to_list(Stream, Line6),
  stream_to_list(Stream, Line7),
  stream_to_list(Stream, Line8),
  stream_to_list(Stream, Line9),
  stream_to_list(Stream, Line10),
  stream_to_list(Stream, Line11),
  stream_to_list(Stream, Line12),
  stream_to_list(Stream, Line13),
  stream_to_list(Stream, Line14),
  stream_to_list(Stream, Line15),

  % Hint 1
  sentence(Line1, Offices),
  % Hint 2
  sentence(Line2, Offices),
  % Hint 3
  sentence(Line3, Offices),
  % Hint 4
  sentence(Line4, Offices),
  % Hint 5
  sentence(Line5, Offices),
  % Hint 6
  sentence(Line6, Offices),
  % Hint 7
  sentence(Line7, Offices),
  % Hint 8
  sentence(Line8, Offices),
  % Hint 9
  sentence(Line9, Offices),
  % Hint 10
  sentence(Line10, Offices),
  % Hint 11
  sentence(Line11, Offices),
  % % Hint 12
  sentence(Line12, Offices),
  % % Hint 13
  sentence(Line13, Offices),
  % Hint 14
  sentence(Line14, Offices),
  % Hint 15
  sentence(Line15, Offices).

generateRiddle(File, Offices) :-
  length(Offices, 5),
  open(File, read, Stream),

  stream_to_list(Stream, Line1),
  stream_to_list(Stream, Line2),
  stream_to_list(Stream, Line3),
  stream_to_list(Stream, Line4),
  stream_to_list(Stream, Line5),
  stream_to_list(Stream, Line6),
  stream_to_list(Stream, Line7),
  stream_to_list(Stream, Line8),
  stream_to_list(Stream, Line9),
  stream_to_list(Stream, Line10),
  stream_to_list(Stream, Line11),
  stream_to_list(Stream, Line12),
  stream_to_list(Stream, Line13),
  stream_to_list(Stream, Line14),
  stream_to_list(Stream, Line15),

  % Hint 1
  sentence(Line1, Offices),
  % Hint 2
  sentence(Line2, Offices),
  % Hint 3
  sentence(Line3, Offices),
  % Hint 4
  sentence(Line4, Offices),
  % Hint 5
  sentence(Line5, Offices),
  % Hint 6
  sentence(Line6, Offices),
  % Hint 7
  sentence(Line7, Offices),
  % Hint 8
  sentence(Line8, Offices),
  % Hint 9
  sentence(Line9, Offices),
  % Hint 10
  sentence(Line10, Offices),
  % Hint 11
  sentence(Line11, Offices),
  % % Hint 12
  sentence(Line12, Offices),
  % % Hint 13
  sentence(Line13, Offices),
  % Hint 14
  sentence(Line14, Offices),
  % Hint 15
  sentence(Line15, Offices), !.

student(Major) :-
  generateRiddle('Hints.txt', Offices),
  member(s(taekwondo, _, Major, _, _), Offices), !.
