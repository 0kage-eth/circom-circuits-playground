pragma circom 2.1.6;
include "circomlib/comparators.circom";

// Puzzle 8 - Circuit to verify that the first input is the floor of the integer square root of the second input
// zkREPL gist - https://gist.github.com/0kage-eth/630bffc994291ecfad7d45997d4fc52f

// Create a circuit that is satisfied if
// in[0] is the floor of the integer integer
// sqrt of in[1]. For example:
// 
// int[2, 5] accept
// int[2, 5] accept
// int[2, 9] reject
// int[3, 9] accept
//
// If b is the integer square root of a, then
// the following must be true:
//
// (b - 1)(b - 1) < a
// (b + 1)(b + 1) > a
// 
// be careful when verifying that you 
// handle the corner case of overflowing the 
// finite field. You should validate integer
// square roots, not modular square roots

template IntSqrt(n) {
    signal input in[2];
    // my assumption here is that in[0] and in[1] are both integers


    // step 1 - first check if in[1] only accepts non-negative integers
    // we don't want to handle cases when in[1] could be negative

    component nonNegativeChk = GreaterEqThan(n);
    nonNegativeChk.in[0] <== in[1];
    nonNegativeChk.in[1] <== 0; 
    nonNegativeChk.out === 1; // constraint ensures square is always non-negative
    
    // step 2 -> handle the 0 case as the above conditions fail when in[1] == 0
    //  in[1] == 0 -> in this case, in[0] == 0 should pass
    // but (in[0] -1) * (in[0] -1) < in[1] fails because this turns to (-1) * (-1) = 1 < 0
    // similarly (in[0] + 1)* (in[0] +1) > in[1] fails 

    component isRootZero = IsZero();
    component isSquareZero = IsZero();

    isRootZero.in <== in[0];
    isSquareZero.in <== in[0];

    isSquareZero.out * (1 - isRootZero.out) === 0; // if square is 0 (isSquareZero.out == 1), then root must also be 0 (isRootZero.out == 1)

    // for non zero square: in[1] != 0, we need to change the lessThanCheck

    signal oneMinus <== in[0] - 1;
    signal onePlus <== in[0] + 1;

    component lessThanChk = LessThan(n);
    component greaterThanChk = GreaterThan(n);

    lessThanChk.in[0] <== oneMinus * oneMinus;
    lessThanChk.in[1] <== in[1];
    (1 - isSquareZero.out)* (lessThanChk.out - 1) === 0; // check will only matter if square is positive number

    greaterThanChk.in[0] <== onePlus * onePlus;
    greaterThanChk.in[1] <== in[1];
    

    // now check if there is overflow
    component overflowChk = LessThan(n);
    overflowChk.in[0] <== onePlus * onePlus;
    overflowChk.in[1] <== oneMinus * oneMinus;

    signal overflow;
    overflow <-- overflowChk.out == 1 ? 1 : 0; // 1 here means overflow
    signal greaterChkWithOverflow <== (1- overflow)* (1 - greaterThanChk.out);
    // if square is 0, anything after does not matter
    // overflow = 1, then greaterThanChk output does not matter
    // overflow = 0, then greaterThanChk output has to be 1
    // this handles the overflow case correctly
    (1- isSquareZero.out) * greaterChkWithOverflow === 0; 

    // another check here should be that in[0] * in[0] <= in[1]
    // just the less than and greater than check will not be enough
    // suppose in[0] = 4, in[1] = 10, (in[0] - 1) * (in[0] -1) = 9 < 10
    // (in[0] + 1)*(in[0] + 1) = 25 > 10. But 4 is not a solution here 
    // added check here is that in[0] * in[0] <= in[1] -> if this holds, then we are sure that in[0] is the floor 

    component lessEqualChk = LessEqThan(n);
    lessEqualChk.in[0] <== in[0] * in[0];
    lessEqualChk.in[1] <== in[1];

    lessEqualChk.out === 1; // this ensures the final condition

}

component main = IntSqrt(252);

/*
INPUT = {
    "in": ["0", "0"]
}
*/