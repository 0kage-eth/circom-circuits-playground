pragma circom 2.0.6;
include "../node_modules/circomlib/circuits/mimcsponge.circom";


//@note tornado like mixer with 3 depositors -> can be generalized to N depositors 
//@note prove that you have a pre-image of one of the hashes in the tornado cash contract
// this is needed at the time of withdrawal

template TornadoCash3() {
    signal input note; // pre-image by user


    // hashes of depositors
    signal input hash1; 
    signal input hash2;
    signal input hash3;

    signal output usedHash;

    component mimc = MiMCSponge(1, 220, 1);
    component mimcNullifier = MiMCSponge(1, 220, 1);

    signal hash; // hash of the note 

    // create a hash with mimc circuit using note as input
    mimc.ins[0] <== note;
    mimc.k <== 0;
    hash <== mimc.outs[0];

    mimcNullifier.ins[0] <== hash;
    mimcNullifier.k <== 0;

    signal constraint1 <-- (hash - hash1) * (hash - hash2);
    signal finalConstraint <-- constraint1 * (hash - hash3);
    finalConstraint === 0; // constraint that the hash is one of the depositors

    usedHash <== mimcNullifier.outs[0];
}

component main = TornadoCash3();