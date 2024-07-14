pragma circom 2.1.6;

include "circomlib/comparators.circom";
//Puzzle 17 - Quadratic Equation verifier with overflow checks
// gist: https://gist.github.com/0kage-eth/1fbc7513e906259b8921b425c9ea3514

// Create a Quadratic Equation( ax^2 + bx + c ) verifier using the below data.
// Use comparators.circom lib to compare results if equal

template QuadraticEquation() {
    signal input x;     // x value
    signal input a;     // coeffecient of x^2
    signal input b;     // coeffecient of x 
    signal input c;     // constant c in equation
    signal input res;   // Expected result of the equation
    signal output out;  // If res is correct , then return 1 , else 0 . 

    // your code here
    signal x_squared <-- x * x;
    signal eq_val <-- a*x_squared + b*x + c;

    // check for overflow
    component overflowChk = LessThan(252); // assume 252 bit field
    overflowChk.in[0] <== eq_val;
    overflowChk.in[1] <== 1<<252 -1; // 2^252 -1

    overflowChk.out === 1; // prevents overflow

    component zeroChk = IsZero();
    zeroChk.in <== eq_val - res;

    out <== zeroChk.out;
}

component main  = QuadraticEquation();

/*
INPUT = {
    "x": "2",
    "a": "5",
    "b": "3",
    "c": "10",
    "res": "36"
}
*/

// overflow input chk for x = 2^252
//INPUT = {
//    "x": "5708990770823839524233143877797980545530986495",
//    "a": "5",
//    "b": "3",
//    "c": "10",
//    "res": "36"
//}