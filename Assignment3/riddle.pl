major(architecture).
major(cse).
major(gs).
major(itws).
major(cs).

club(rpi_flying_club).
club(taekwondo).
club(rcos).
club(r_gaming_alliance).
club(cs).

genre(sci_fi).
genre(fantasy).
genre(fiction).
genre(poetry).
genre(history).

poster(ctrl_alt_delete).
poster(dilbert)
poster(calvin_and_hobbes).
poster(xkcd).
poster(phd_comics).

pizza(cheese).
pizza(pepperoni).
pizza(broccoli).
pizza(buffalo_chicken).
pizza(hawaiian).

% Facts
occupies(architecture, ctrl_alt_delete).
member(cse, rpi_flying_club).
reads(gs, sci_fi).
eats(itws, broccoli).

occupies(X) :-

% Office #, Major, Club, Genre, Poster, Pizza
offices(0, []) :- !.
Offices = [
  office(1, Major1, Club1, Genre1, Poster1, Pizza1),
  office(2, Major2, Club2, Genre2, Poster2, Pizza2),
  office(3, Major3, Club3, Genre3, Poster3, Pizza3),
  office(4, Major4, Club4, Genre4, Poster4, Pizza4),
  office(5, Major5, Club5, Genre5, Poster5, Pizza5)
].
