pragma circom 2.0.6;
include "../node_modules/circomlib/circuits/MiMCSponge.circom";

/* @note a generic group signatures circuit that takes N public keys
a private secret key, and a message. Circuit verifies that the sender is indeed
one of the N public keys, and that the signature is valid.
*/

template GroupSignatures(N) {

    assert(N > 2); // should atleast be 2 members in the group

    signal input pubKeys[N];
    signal input privKey;

    signal input msg; // public message

    signal output attestation; // msg attestation, signed by priv key 

    signal multiplyKeys[N];
    signal keyHash;

    component mimc = MiMCSponge(1, 220, 1);
    // 1 input signal, 1 output signal with 220 rounds

    mimc.ins[0] <== privKey;
    mimc.k <== 0;
    mimc.outs[0] ==> keyHash;

    multiplyKeys[0] <== (keyHash - pubKeys[0]);
    for(var i =1; i< N; i++){
        multiplyKeys[i] <==   multiplyKeys[i-1] * (keyHash - pubKeys[i]);
    }

    multiplyKeys[N-1] === 0; // constraint that the private key is one of the public keys

    // sign the message
    component attestGen = MiMCSponge(2, 220, 1);

    attestGen.ins[0] <== privKey;
    attestGen.ins[1] <== msg;
    attestGen.k <== 0;
    attestGen.outs[0] ==> attestation; // final attestation
}

component main{public [pubKeys, msg]} = GroupSignatures(3);