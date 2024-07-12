pragma circom 2.1.6;

// Puzzle 4- FourBitBinary: Circuit to check if a number is a binary reprsentation of its bits
// find zkREPL implementation here 
// https://gist.github.com/0kage-eth/51ad0e2995e2fd127505902092e82b92


// Create a circuit that takes an array of four signals
// `in`and a signal s and returns is satisfied if `in`
// is the binary representation of `n`. For example:
// 
// Accept:
// 0,  [0,0,0,0]
// 1,  [1,0,0,0]
// 15, [1,1,1,1]
// 
// Reject:
// 0, [3,0,0,0]
// 
// The circuit is unsatisfiable if n > 15

template FourBitBinary() {
    signal input in[4];
    signal input n;

    in[3]*(in[3]-1) === 0;
    in[2]*(in[2]-1) === 0;
    in[1]*(in[1]-1) === 0;
    in[0]*(in[0]-1) === 0;

    in[3] * 2 **3 + in[2] * 2**2 + in[1] * 2 + in[0] === n;
}

component main{public [n]} = FourBitBinary();

/* INPUT = {

    "in": ["1","1","1","1"],
    "n": "15"
}
*/