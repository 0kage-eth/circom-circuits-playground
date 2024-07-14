pragma circom 2.1.6;

// Create a circuit which takes an input 'a',(array of length 2 ) , then  implement power modulo 
// and return it using output 'c'.

// HINT: Non Quadratic constraints are not allowed. 


template Multiply(){
    signal input a;
    signal input b;
    signal output c;

    c = a * b;



}
template Pow(m) { //@note I guess the modulo is missing -> I've assumed that it is a constant passed as param
   
   signal input a[2];
   signal output c;

   // c = a[0] ^ a[1] % m



}

component main = Pow(10);
