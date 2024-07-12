pragma circom 2.1.6;
include "circomlib/comparators.circom";

// gist:  https://gist.github.com/0kage-eth/1d65ebbe23baa6f93fb6028362c30b22

// Create a circuit that is satisfied if `numerator`,
// `denominator`, `quotient`, and `remainder` represent
// a valid integer division. You will need a comparison check, so
// we've already imported the library and set n to be 252 bits.
//
// Hint: integer division in Circom is `\`.
// `/` is modular division
// `%` is integer modulus

template IntDiv(n) {
    signal input numerator;
    signal input denominator;
    signal input quotient;
    signal input remainder;

    signal calcQuotient;
    signal calcReminder;
    signal calcNumerator;

    // first step, check the denominator is not zero
    component zeroCheck = IsZero();
    zeroCheck.in <== denominator;
    zeroCheck.out === 0; // zeroCheck.out == 0 only if denominator != 0

    // second step, check that remainder is a value less than denominator
    component lessThanCheck = LessThan(n);
    lessThanCheck.in[0] <== remainder;
    lessThanCheck.in[1] <== quotient;
    lessThanCheck.out === 1;

    // final step -> check that the numbers correctly add up
    calcQuotient <-- numerator \ denominator;
    calcReminder <-- numerator % denominator;

    calcNumerator <== calcQuotient * denominator + calcReminder;

    calcNumerator === numerator;
}

component main = IntDiv(252);


/*
INPUT = {
    "numerator": "55",
    "denominator": "4",
    "quotient": "13",
    "remainder": "3"
}
*/