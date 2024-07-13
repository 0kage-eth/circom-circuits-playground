pragma circom 2.1.6;
include "circomlib/comparators.circom";

//Puzzle 7 - Circuit to divide two numbers and assign the quotient in `out`
// gist - https://gist.github.com/0kage-eth/46fc069f709d049451c6e52d42ec3223

// Use the same constraints from IntDiv, but this
// time assign the quotient in `out`. You still need
// to apply the same constraints as IntDiv

template IntDivOut(n) {
    signal input numerator;
    signal input denominator;
    signal output out;

    signal calcQuotient;
    signal calcReminder;

    // first step, check the denominator is not zero
    component zeroCheck = IsZero();
    zeroCheck.in <== denominator;
    zeroCheck.out === 0; // zeroCheck.out == 0 only if denominator != 0

    // second step -> calculate quotient and reminder
    calcQuotient <-- numerator \ denominator;
    calcReminder <-- numerator % denominator;

    // third step -> check that remainder is less than denominator
    component ltCheck = LessThan(n);
    ltCheck.in[0] <== calcReminder;
    ltCheck.in[1] <== denominator;
    ltCheck.out === 1;

    // fourth step -> assign constraints
    numerator === calcQuotient * denominator + calcReminder;

    out <== calcQuotient;
}

component main = IntDivOut(252);


/*
INPUT = {
    "numerator": "55",
    "denominator": "4"
}
*/