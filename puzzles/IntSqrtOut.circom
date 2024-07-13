pragma circom 2.1.6;
include "circomlib/comparators.circom";
include "gist:630bffc994291ecfad7d45997d4fc52f";

// Puzzle 9 - Compute root and add constraints to verify that integer root is properly calculated
// I am using the inSqrt in gist:630bffc994291ecfad7d45997d4fc52f that I've already implemented
// included in scope

// gist: https://gist.github.com/0kage-eth/b9b3fba5f78505335e421ece033223e6

// Be sure to solve IntSqrt before solving this 
// puzzle. Your goal is to compute the square root
// in the provided function, then constrain the answer
// to be true using your work from the previous puzzle.
// You can use the Bablyonian/Heron's or Newton's
// method to compute the integer square root. Remember,
// this is not the modular square root.


function intSqrtFloor(x) { //@note this is a function and not a template
    // compute the floor of the
    // integer square root
   if (x == 0) return 0;
   if (x == 1) return 1;

   var left = 0;
   var right = x;

   while(right > left + 1){
       var m = (left + right)\2;
       if (m*m <= x){
           left = m;
       }else{
           right = m;
       }
   }
   return left; // floor of the root

}

template IntSqrtOut(n) {
    signal input in;
    signal output out;

    
    // first check if x is non-negative
    component nonnegativeChk = GreaterEqThan(n);

    nonnegativeChk.in[0] <== in;
    nonnegativeChk.in[1] <== 0;
    nonnegativeChk.out === 1; // fails for negative input

    // finally compute out    
    var root = intSqrtFloor(in);
    // constrain out using your
    // work from IntSqrt

    out <-- root;
    component intSqrtChk = IntSqrt(n);

    intSqrtChk.in[0] <== out;
    intSqrtChk.in[1] <==  in;

}

component main = IntSqrtOut(252);

/*
INPUT = {
    "in": 0
}
*/