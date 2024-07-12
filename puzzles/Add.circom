pragma circom 2.0.6;

// puzzle 1 - Add: Circuit to prove that first element in input signal array is sum of next two elements
// find zkREPL implementation here 
// https://gist.github.com/0kage-eth/ce965a67ca5508fe49c6fc03e6b8db45

template Add() {
    signal input a[3];

    a[0] === a[1] + a[2];
}

component main = Add();

