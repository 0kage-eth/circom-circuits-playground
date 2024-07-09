pragma circom 2.0.3;
/* 
 - a circuit that gets the inverse of any input and checks if 
 - constraint is the input * inv === 0
 - inverse is 

*/
template IsZero() {
    signal input inp;
    signal output out;

    signal tmp;

    tmp <-- inp == 0 ? 1 : 1 / inp; //assign - 1/inp is valid here 

    out <== - inp * tmp + 1; //assign and constraint

    inp * out === 0; // constraint should always be true
}

component main  = IsZero();