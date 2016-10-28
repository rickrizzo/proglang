# Programming Languages Assignment 2
Robert Russo and Robert Rotering

## Operations
This DNA sequencer works by implementing a concurrent algorithm based on merge sort. As the merge goes on, certain events trigger a count message to be sent back to the main thread where the number of inversions can be tallied concurrently.

## Special Features
We created a special function to switch to either a distributed or concurrent behavior based on how the program is executed.
