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
| [0xPARC notes](./notes/oxparc-notes.md)   | Notes from zk training         |   
| [circom](./notes/circom.md)     | Circom docs and concepts         |
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


--- 

## Articles

1. [ZK Detailed Review - Christian Reitwiessner](https://blog.ethereum.org/2016/12/05/zksnarks-in-a-nutshell) 

2. [Vitalik - 3 article series on zkSNARK](https://medium.com/@VitalikButerin/quadratic-arithmetic-programs-from-zero-to-hero-f6d558cea649)

3. [Intro to zkSnarks - gubsheep](https://blog.zkga.me/intro-to-zksnarks)

## Sample Projects

1. [Dark Forest](https://zkga.me/)


2. [Stealth Air drop](https://github.com/stealthdrop/stealthdrop)

3. [Tornado Cash](??)
mathematically perfect money laundering machine

4. [ZKML](??)
Prove performance of a ML model without revealing it