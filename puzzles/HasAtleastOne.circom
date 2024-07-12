pragma circom 2.1.6;
// gist: https://gist.github.com/0kage-eth/9f0647e6f11aa4553674ab0dabcdbc6a
// helper template to check if a signal is zero
template IsZero() {
    signal input in;
    signal output out;

    signal inv;
    signal tmp;

    inv <-- in == 0 ? 1 : 1/in;
    
    tmp <== -inv*in + 1;
    tmp * in === 0;
    out <== in*inv;
}

// Create a circuit that takes an array of signals `in[n]` and
// a signal k. The circuit should return 1 if `k` is in the list
// and 0 otherwise. This circuit should work for an arbitrary
// length of `in`.


template HasAtLeastOne(n) {
    signal input in[n];
    signal input k;

    component zeroChk[n];
    signal products[n + 1];

    products[0] <== 1;
    for(var i=0; i<n; i++){
        zeroChk[i] = IsZero();
        zeroChk[i].in <== in[i] - k;
        products[i+1] <== products[i] * zeroChk[i].out;    
    }

    // This constraint will fail if k is not in the list
    products[n] === 0;
}

component main = HasAtLeastOne(4);

/* INPUT = {
    "in": ["21", "2","12", "13"],
    "k": "12"
}
*/