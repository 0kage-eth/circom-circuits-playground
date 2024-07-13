pragma circom 2.1.6;
include "circomlib/comparators.circom";
// Puzzle 12: Verifies at least one element is 1
// gist: https://gist.github.com/0kage-eth/5c307ab8ea93e77ab4feecd5ce826ac8

// Write a circuit that returns true when at least one
// element is 1. It should return false if all elements
// are 0. It should be unsatisfiable if any of the inputs
// are not 0 or not 1.

template MultiOR(n) {
    signal input in[n];
    signal output out;

    var sum = 0;

    for(var i=0; i < n; i++){
        in[i] * (in[i]-1) === 0; // ensures each element is binary
        sum += in[i];
    }
    component zeroChk = IsZero();
    zeroChk.in <== sum;
    
    out <== (1 - zeroChk.out);
}

component main = MultiOR(4);

/*
INPUT = {
    "in": ["0", "0", "0", "0"]
}
*/