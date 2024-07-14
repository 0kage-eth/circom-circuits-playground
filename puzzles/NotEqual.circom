pragma circom 2.1.6;
include "circomlib/comparators.circom";

//Puzzle 14: Checks if any 2 elements in array are not equal
// https://gist.github.com/0kage-eth/9e7848068f51d821447e88360f12e8b6
// Input : a , length of N .
// Output : c .
// In this exercise , you have to check that a[i] is NOT equal to a[i+1] for all i: [0,N-1], if not equal, output 1, else output 0.
// You are free to use any operator you may like

template NotEqual(N) {

    signal input a[N];
    signal output c;
    // Your code here.

    component neChk[N-1];
    var chk =1;

    for(var i =0; i< N-1; i++){
        neChk[i] = IsEqual();
        neChk[i].in[0] <== a[i];
        neChk[i].in[1] <== a[i+1];

        chk *= (1 - neChk[i].out);
    }

    c <== chk;
   
}

component main = NotEqual(3);

/*
INPUT = {
    "a": ["32", "32", "32"]
}
*/