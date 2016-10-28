# Programming Languages Assignment 2
Robert Russo and Robert Rotering

## Operations
This DNA sequencer works by implementing a concurrent algorithm based on merge sort.

## Special Features
We created a special function to switch to either a distributed or concurrent behavior based on how the program is executed.

## Considerations
Based on the assignment it was not abundantly clear how this program would be run. While this program should work with whatever is thrown at it, in a distributed environment it could potentially perform better if all `spawn/3` calls were replaced with `spawn/4`. As is it will distribute work to other Erlang machines, but it could easily do more as it is currently written. This change was not implemented so it would be easier to run (and only one `main.elr` would be submitted).
