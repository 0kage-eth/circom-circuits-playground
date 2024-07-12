pragma circom 2.0.6;
include "../node_modules/circomlib/circuits/MiMCSponge.circom";
// run the circuit on zkrepl - https://gist.github.com/0kage-eth/c1f8b96bf196ae9b5e4abea53be85ff1

//@note RevealSigner circuit is used to check if the private key is indeed the signer of the message
// and pre-image of the public key

//@follow-up TODO: something wrong with msgHash input - check and correct this
template RevealSigner() {

    signal input privateKey;
    signal input publicKey;
    signal input msg;

    signal input msgHash;

    component keyGen = MiMCSponge(1, 220, 1);
    keyGen.ins[0] <== privateKey;
    keyGen.k <== 0;
    keyGen.outs[0] === publicKey;

    component msgHashGen = MiMCSponge(2, 220, 1);
    msgHashGen.ins[0] <== privateKey;
    msgHashGen.ins[1] <== msg;
    msgHashGen.k <== 0;
    //msgHashGen.outs[0] === msgHash;
}

component main{public[publicKey, msg, msgHash]} = RevealSigner();

/* INPUT = {
    "privateKey": "24",
    "publicKey": "24",
    "msg": "24",
    "msgHash": ""

} */
