pragma circom 2.0.3;

//@note this strangely does not complie when I run in groth16 prover sceheme using snarkjs
//@note but it does compile under plonk scheme - is this because this cannot be arithmetized??
//@follow-up ask someone why this is the case

template Num2Bits(N) {
    signal input num;
    signal output out[N];
    signal output bitVal;
    
    var bitValTemp = 0;
    var mul = 1;

    for (var i = 0; i < N; i++) {
        out[i] <-- (num >> i) & 1; // get the i'th bit
        (out[i] - 1) * out[i] === 0; // constraint that the bit is either 0 or 1
        bitValTemp += mul * out[i];
        mul *= 2;
    }

    bitVal <== bitValTemp; // output the accumulated bit value for debugging
    bitVal === num; // constraint that the bit computation is correct
}

component main {public [num]} = Num2Bits(8);
