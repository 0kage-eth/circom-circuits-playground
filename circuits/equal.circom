pragma circom 2.0.6;
include "../node_modules/circomlib/circuits/comparators.circom";

template Are2NumbersEqual(){

    signal input a[2];
    signal output out;

    signal diff <== a[0] - a[1];
    component zero = IsZero();

    zero.in <== diff;

    out <== zero.out;
    // out === 1; //@note when input ===0, which it will be if equal, then output should be 1
}

component main = Are2NumbersEqual();