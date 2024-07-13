pragma circom 2.1.6;
include "circomlib/poseidon.circom";

// Puzzle 15 (Not Really): Implement Poseidon Hashing
//gist: https://gist.github.com/0kage-eth/cc35387d7aaa3e5234db27fb2fedb1c5

// Go through the circomlib library and import the poseidon hashing template using node_modules
// Input 4 variables,namely,'a','b','c','d' , and output variable 'out' .
// Now , hash all the 4 inputs using poseidon and output it . 
template poseidon() {
    signal input a;
    signal input b;
    signal input c;
    signal input d;

    signal output out;


    component pos = Poseidon(4);
    pos.inputs[0] <== a;
    pos.inputs[1] <== b;
    pos.inputs[2] <== c;
    pos.inputs[3] <== d;

    out <== pos.out;
}

component main = poseidon();

/*
INPUT = {
"a": "10",
"b": "20",
"c": "30",
"d": "40"
}
*/

// returns output: 3115281239805795994436322590308493735630519107973543550375762423685232930936