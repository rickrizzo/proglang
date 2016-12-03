# Programming Languages Assignment 3

#### Robert Russo and Robert Rotering

## Language
This program was written using SWIPL Prolog.

## Design Considerations
To solve the riddle, an array oriented design was used in order to model relationships such as next to and left of. It was assumed that left of meant immediately left of. Because of this design choice, the NLP version of the program searches for key words/phrases within the given hints and then pattern matches these to specific rules regarding the array. Assert did not work with the member function, which made using it difficult, likely due to the naive nature of the programmers.

## Shortcomings
This program has difficulty handling punctuation and multi word atoms in the input files. Because of this those characters have been omitted from the input file, and multi word phrases have been substituted with underscores between them. For example, buffalo chicken became buffalo_chicken.
