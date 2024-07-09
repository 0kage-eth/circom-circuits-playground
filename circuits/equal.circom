pragma circom 2.0.6;
include "../node_modules/circomlib/circuits/comparators.circom";

/**
Circuit proves 2 numbers are equal without knowing actual numbers
behavior of this circuit is if inputs are equal, out === 1 else out === 0
uses the isZero component from circomlib
*/
template Are2NumbersEqual(){

    signal input a[2];
    signal output out;

    signal diff <== a[0] - a[1];
    component zero = IsZero();

    zero.in <== diff;

    out <== zero.out;
   
}

component main = Are2NumbersEqual();