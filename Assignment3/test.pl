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

% Helper Functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% String to List
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
  % Could be used to make one master sentence function to reduce repitition
  % (leftposition(Position) -> write('WE ARE ON THE LEFT'), nl
  % ; write('WE ARE NOT ON THE LEFT'), nl).

% Sentence

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
% Main
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
generateRiddle(File) :-
  length(Offices, 5),
  open(File, read, Stream),

  % Hint 1
  write('one'), nl,
  stream_to_list(Stream, Line1),
  sentence(Line1, Offices),

  write(Offices), nl.
