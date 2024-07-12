pragma circom 2.0.6;
include "../node_modules/circomlib/circuits/mimcsponge.circom";
include "../node_modules/circomlib/circuits/comparators.circom";

//@note DenySigner circuit is used to verify that a private key has not signed a message hash

template DenySigner() {

    signal input privateKey;
    signal input publicKey;
    signal input msg;
    signal input msgHash;
    signal tmpHash;


    component keyGen = MiMCSponge(1, 220, 1);
    keyGen.ins[0] <== privateKey;
    keyGen.k <== 0;
    keyGen.outs[0] === publicKey;

    component msgHashGen = MiMCSponge(2, 220, 1);
    msgHashGen.ins[0] <== privateKey;
    msgHashGen.ins[1] <== msg;
    msgHashGen.k <== 0;
    msgHashGen.outs[0] ==> tmpHash;

    component equalChk = IsEqual();
    signal eq;

    equalChk.in[0] <== tmpHash;
    equalChk.in[1] <== msgHash;

    eq <== equalChk.out;

    eq === 0; 
}
component main{public [publicKey, msg, msgHash]} = DenySigner();

/* INPUT = {
    "privateKey": "42",
    "publicKey": "10644022205700269842939357604110603061463166818082702766765548366499887869490",
    "msg": "22244343",
    "msgHash": "19833928673421348099551208308550845034353984796187223518782099197661428039949"
} */