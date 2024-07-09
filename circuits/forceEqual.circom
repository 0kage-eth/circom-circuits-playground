pragma circom 2.0.6;
include "../node_modules/circomlib/circuits/comparators.circom";

/**
Circuit forces 2 numbers to be equal without knowing actual numbers
Unlike the equal circuit, this one has no output, it just forces the numbers to be equal
*/
template ForceEqual(){
    signal input in[2];

    signal diff <== in[0] - in[1];
    component zero = IsZero();

    zero.in <== diff;

    1- zero.out === 0; //@note out === 1 only if numbers are equal
}

component main = ForceEqual();