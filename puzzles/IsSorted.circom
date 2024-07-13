pragma circom 2.1.6;
include "circomlib/comparators.circom";

// Puzzle 10: Verifies if the elements in input array are sorted in ascending order
// gist: https://gist.github.com/0kage-eth/058ec7e9e5b18cfcb5627ca1f076751e

// Write a circuit that constrains the N input signals to be
// sorted. Sorted means the values are non decreasing starting
// at index 0. The circuit should not have an output.

template IsSorted(N) {
    signal input in[N];

    assert(N > 1); // sorting needs atleast 2 elements
    component lessThanEqualChk[N-1];    
    for(var i=0; i<N-1; i++){
        lessThanEqualChk[i] = LessEqThan(252);
        lessThanEqualChk[i].in[0] <== in[i];
        lessThanEqualChk[i].in[1] <== in[i+1];
        lessThanEqualChk[i].out === 1;
    }
}

component main = IsSorted(4);

/*
INPUT = {
    "in": ["21", "32", "32", "43"]
}
*/