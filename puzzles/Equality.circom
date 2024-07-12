pragma circom 2.0.6;

// puzzle 3 - Circuit to prove that each value in the array is equal
// https://gist.github.com/0kage-eth/a4d0d850871e500263857b83a48b62b3

template Equality (N) {
    signal input in[N];
    
    for (var i=1; i< N; i++){
        in[i] === in[i-1];
    }
}

component main = Equality(4);

/* INPUT = {
    "in": ["24", "24", "24", "24"] 
} */