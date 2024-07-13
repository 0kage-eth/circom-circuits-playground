pragma circom 2.1.6;

//Puzzle 13: Simple multiplication for 3 elements in an array
// gist: https://gist.github.com/0kage-eth/b0aae9af4dc157871669b0edb3575fa0

// Your circuit should constrain the third signal in `in`
// to be the product of the first two signals

template MultiplyNoOutput() {
    signal input in[3];

    in[2] === in[0] * in[1];
}

component main = MultiplyNoOutput();

/*
INPUT = {
    "in": ["12", "2", "24"]
} 
*/