pragma circom 2.1.6;
include "circomlib/comparators.circom";
// Puzzle 11: Verifies all inputs are binary and if all 1's, then 1 else 0
// gist: https://gist.github.com/0kage-eth/2a0958b1a5c5f5b051263d774a96bd29

// Create a circuit that takes an array of signals `in` and
// returns 1 if all of the signals are 1. If any of the
// signals are 0 return 0. If any of the signals are not
// 0 or 1 the circuit should not be satisfiable.

template MultiAND(n) {
    signal input in[n];
    signal output out;

    var sum;
    for(var i=0; i< n; i++){
        in[i] * (in[i] -1) === 0; // ensures binary
        sum += in[i];
    }

    signal sumSig;
    sumSig <-- sum;

    signal all1Sig;
    all1Sig <-- n;

    component isEqCheck = IsEqual();

    isEqCheck.in[0] <== sumSig;
    isEqCheck.in[1] <== all1Sig;

    out <== isEqCheck.out; 

}

component main = MultiAND(4);

/*
INPUT = {
    "in": ["1", "1", "1", "1"]
}
*/