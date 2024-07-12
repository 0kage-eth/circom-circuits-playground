pragma circom 2.0.6;

// Puzzle 2- AllBinary: Circuit to prove that every element in input signal array is either 0 or 1
// find zkREPL implementation here 
// https://gist.github.com/0kage-eth/34b84996d8bde561668a5b34c0ff769a
template AllBinary(N){
    signal input in[N];

    for(var i=0;i<N;i++){
        in[i]*(in[i]-1) === 0; // ensures that in[i] is either 0 or 1
    }
}

component main = AllBinary(4);