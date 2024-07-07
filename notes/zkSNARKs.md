# zkSNARKs

Read couple of articles on zkSNARK. My understanding on some practical aspects

## Christian Reitwiessner

[This article](https://blog.ethereum.org/2016/12/05/zksnarks-in-a-nutshell) published by Ethereum foundation gives a good overview. Some key points here:


- At a very high level, a zkSNARK has 4 key steps
    - Encoding a problem statement into a quadratic equation of polynomials
        `t(x)h(x) = w(x)v(x)` -> this equality holds if and only if program is computed correctly

    - Verifier chooses a secret evaluation input to reduce polynomial function into a computation `t(s)h(s) = w(s)v(s)`

    - An encoding function E that has homomorphic properties (see [0xParc notes Lesson 1](./oxparc-notes.md) to know what this means). This allows prover to compute
    `E(t(s)), E(h(s)), E(w(s)), E(v(s))` without knowing `s`. Prover only knows `E(s)` 

    - Zero knowledge proof - prover permutes values of `E(t(s)), E(h(s)), E(w(s)), E(v(s))` by multiplying with a number so that verifier can verify their structure without knowing actual encoded values

    - 



 [Vitalik](https://medium.com/@VitalikButerin/quadratic-arithmetic-programs-from-zero-to-hero-f6d558cea649)