# circom-circuits playground

## why
As a security auditor, I am learning about zkp's from ground zero. I find the existing material either too theoretical or research oriented.

I am creating this repo to track my journey in the learning process with a practitioner focus. I might keep changing the order of subjects & topics here as I gain more understanding - but the key intent is to make learning easy, intuitive and sticky.

---

## intro
Project forked from @0xPARC repo for [circuit-starter](https://github.com/0xPARC/circom-starter). This project uses [hardhat-circom](https://github.com/projectsophon/hardhat-circom) to generate and verify proofs via Circom and SnarkJS.

Project contains multiple circuits - each circuit can be compiled to output the `wasm` and `zkey` files. Project automatically generates verifier solidity file that can be used by a protocol to verify the key.

---

## Documentation
Refer the notes section:

| Topic | Summary |
|-----|-----------|
| [Intro to ZK](./notes/intro2zk.md)   | ZK intro with practical use-cases         |   
| [0xPARC notes](./notes/oxparc-notes.md)   | Notes from zk training         |   
| [circom](./notes/circom.md)     | Circom docs and concepts         |
| [zkSNARKS](./notes/zkSNARKs.md)     | ZK Snarks concepts         |
| [groth16](./notes/groth16.md)   | All about groth16 prover         |
| [r1c1](./notes/r1c1.md)         | All about r1c1 arithmetization         |
| [halo](./notes/halo.md)         | Halo docs, concepts and notes         |

---

## Install

`yarn` to install dependencies

---

## Development builds

`yarn circom:dev` to build deterministic development circuits.

Further, for debugging purposes, you may wish to inspect the intermediate files. This is possible with the `--debug` flag which the `circom:dev` task enables by default. You'll find them (by default) in `artifacts/circom/`

To build a single circuit during development, you can use the `--circuit` CLI parameter. For example, if you make a change to `hash.circom` and you want to _only_ rebuild that, you can run `yarn circom:dev --circuit hash`.

---

## Production builds

`yarn circom:prod` for production builds (using `Date.now()` as entropy)

---

## Resources & Tools

- [zk REPL](https://zkrepl.dev/) - a remix like playground for building and checking circuits - found this super helpful to test circuits

- [circomlib](https://github.com/iden3/circomlib/tree/master/circuits) - good list of tested circuits that are great to understand how circuits can be setup & modularized

- [zk bug tracker](https://github.com/0xPARC/zk-bug-tracker?tab=readme-ov-file#dark-forest-1) - great resource for auditors to understand the nature of bugs & implementation issues related to zk circuits. 

- [snarkJS](https://github.com/iden3/snarkjs) 

- [hardhat circom](https://github.com/projectsophon/hardhat-circom)

- [xkSNARK](https://github.com/akosba/xjsnark)

- [Dark Forest Game](zkga.me)
---

## Circuits

Built following circuits in this repo

| Circuit Name | Explanation |
|--------------|-------------|
| [Zero](./circuits/zero.circom)     | Circuit to prove inverse of a number|
| [Num2bits](./circuits/num2bits.circom)     | Circuit to prove conversion from number to bits|
| [Equal](./circuits/equal.circom)     | Circuit returns 1 if 2 numbers are equal, 0 otherwise|
| [ForceEqual](./circuits/forceEqual.circom)     | Circuit asserts that 2 inputs are the same|
| [Tornado](./circuits/tornadocash3.circom)     | Simplified tornado withdrawal prover with 3 depositors|
| [Group Messaging](./circuits/groupSignatures.circom)     | Generalized N player anonymous messaging|
| [Reveal Signer](./circuits/revealSigner.circom)     | Reveals a user as a signer in anonymous group messaging|
| [Deny Signer](./circuits/denySigner.circom)     | Denies that a user is a signer in anonymous group messaging|
--- 

## Articles

1. [ZK Detailed Review - Christian Reitwiessner](https://blog.ethereum.org/2016/12/05/zksnarks-in-a-nutshell) 

2. [Vitalik - 3 article series on zkSNARK](https://medium.com/@VitalikButerin/quadratic-arithmetic-programs-from-zero-to-hero-f6d558cea649)

3. [Intro to zkSnarks - gubsheep](https://blog.zkga.me/intro-to-zksnarks)

4. [Group Signatures using ZK Proofs](https://github.com/gubsheep/zk-group-sigs)

## Real Life Projects / Use-cases

1. [Dark Forest](https://zkga.me/)

2. [Stealth Air drop](https://github.com/stealthdrop/stealthdrop)

3. [Tornado Cash](??)
mathematically perfect money laundering machine

4. [ZKML](??)
Prove performance of a ML model without revealing it

5. [Cabal](cabal.xyz)
Proof of membership

---
## Puzzles

Implementation of short puzzles, largely taken from [Rareskills repo](https://github.com/RareSkills/zero-knowledge-puzzles/tree/main). Posting the file and corresponding zkREPL gist.


|#| Puzzle | Explanation | Gist |
|--|--------------|-------------|
|1| [Add](./puzzles/Add.circom)     | Checks first element in array is sum of other 2 elements| [gist](https://gist.github.com/0kage-eth/ce965a67ca5508fe49c6fc03e6b8db45) |
|2| [AllBinary](./puzzles/AllBinary.circom)     | Checks every element is either 0 or 1|[gist](https://gist.github.com/0kage-eth/34b84996d8bde561668a5b34c0ff769a)|
|3| [Equality](./puzzles/Equality.circom)     | Checks each element in an array is the same|[gist](https://gist.github.com/0kage-eth/a4d0d850871e500263857b83a48b62b3)|
|4| [FourBitBinary](./puzzles/FourBitBinary.circom)     | Checks if a number is binary representation of its 4 bit array|[gist](https://gist.github.com/0kage-eth/51ad0e2995e2fd127505902092e82b92)|
|5| [HasAtleastOne](./puzzles/HasAtleastOne.circom)     | Checks if atleast one element in array matches a specific value|[gist](https://gist.github.com/0kage-eth/9f0647e6f11aa4553674ab0dabcdbc6a)|
|6| [IntDiv](./puzzles/IntDiv.circom)     | Checks integer division |[gist](https://gist.github.com/0kage-eth/1d65ebbe23baa6f93fb6028362c30b22)|
|7| [IntDivOut](./puzzles/IntDivOut.circom)     | Checks integer division and outputs quotient |[gist](https://gist.github.com/0kage-eth/46fc069f709d049451c6e52d42ec3223)|
|8| [IntSqrt](./puzzles/InSqrt.circom)     | Checks the integer square root of a number |[gist](https://gist.github.com/0kage-eth/630bffc994291ecfad7d45997d4fc52f)|
|9| [IntSqrtOut](./puzzles/InSqrtOut.circom)     | Calculates the integer square root and checks constraints |[gist](https://gist.github.com/0kage-eth/b9b3fba5f78505335e421ece033223e6)|
|10| [IsSorted](./puzzles/IsSorted.circom)     | Checks all elements in array are sorted in ascending order|[gist](https://gist.github.com/0kage-eth/058ec7e9e5b18cfcb5627ca1f076751e)|
|11| [MultiAND](./puzzles/MultiAND.circom)     | Checks all elements are binaries and output is 1 if all 1s, 0 otherwise|[gist](https://gist.github.com/0kage-eth/2a0958b1a5c5f5b051263d774a96bd29)|
|12| [MultiOR](./puzzles/MultiOR.circom)     | Checks all elements are binaries and output is 1 if atleast one element is 1|[gist](https://gist.github.com/0kage-eth/5c307ab8ea93e77ab4feecd5ce826ac8)|
|13| [MultiplyNoOutput](./puzzles/MultiplyNoOutput.circom)     | Checks third element in array is multiplication of first 2|[gist](https://gist.github.com/0kage-eth/b0aae9af4dc157871669b0edb3575fa0)|
|14| [NotEqual](./puzzles/NotEqual.circom)     | Checks if any 2 elements in array are not equal|[gist](https://gist.github.com/0kage-eth/9e7848068f51d821447e88360f12e8b6)|
|15| [Poseidon](./puzzles/Poseidon.circom)     | Checks Poseidon hash of 4 elements|[gist](https://gist.github.com/0kage-eth/cc35387d7aaa3e5234db27fb2fedb1c5)|
|16| [Pow](./puzzles/Pow.circom)     | Checks power modulo|[gist]()|
|17| [Quadratic](./puzzles/Quadratic.circom)     | Checks quadratic expression value|[gist](https://gist.github.com/0kage-eth/1fbc7513e906259b8921b425c9ea3514)|
|18| [Range](./puzzles/Range.circom)     | Checks if value is in range|[gist](https://gist.github.com/0kage-eth/35dcb280efbd1c0797c9d2df82a42c1d)|
