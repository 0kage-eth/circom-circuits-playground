pragma circom 2.1.6;
include "circomlib/mimcsponge.circom";

//Puzzle 19: Generates a hash using a salt value
//gist: https://gist.github.com/0kage-eth/55de11044c239f357719e5ffd05a240b

// In this exercise, we will learn an important concept related to hashing . There are 2 values a and b. You want to 
// perform computation on these and verify it , but secretly without discovering the values. 
// One way is to hash the 2 values and then store the hash as a reference. 
// There is on problem in this concept , attacker can brute force the 2 variables by comparing the public hash with the resulting hash.
// To overcome this , we use a secret value in the input privately. We hash it with a and b. 

// This way brute force becomes illogical as the cost will increase multifolds for the attacker.


// Input 3 values, a, b and salt. 
// Hash all 3 using mimcsponge as a hashing mechanism. 
// Output the res using 'out'.

template Salt() {
    // Your code here..
    signal input a;
    signal input b;
    signal input salt;

    signal output out;

    component mimcGen = MiMCSponge(3,220,1);
    mimcGen.ins[0] <== a;
    mimcGen.ins[1] <== b;
    mimcGen.ins[2] <== salt;
    mimcGen.k <== 0;
    out <== mimcGen.outs[0];
}

component main  = Salt();
// By default all inputs are private in circom. We will not define any input as public 
// because we want them to be a secret , at least in this case. 

// There will be cases where some values will be declared explicitly public .


/*INPUT = {
    "a": "10",
    "b": "35",
    "salt": "198776"
}
*/