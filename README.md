# circom-circuits playground

Project forked from @0xPARC repo for [circuit-starter](https://github.com/0xPARC/circom-starter). This project uses [hardhat-circom](https://github.com/projectsophon/hardhat-circom) to generate and verify proofs via Circom and SnarkJS.

Project contains multiple circuits - each circuit can be compiled to output the `wasm` and `zkey` files. Project automatically generates verifier solidity file that can be used by a protocol to verify the key.

## Documentation
Refer the notes section:

| Topic | Summary |
|-----|-----------|
| [0xPARC notes](./notes/oxparc-notes.md)   | Notes from zk training         |   
| [circom](./notes/circom.md)     | Circom docs and concepts         |
| [groth16](./notes/groth16.md)   | All about groth16 prover         |
| [r1c1](./notes/r1c1.md)         | All about r1c1 arithmetization         |
| [halo](./notes/halo.md)         | Halo docs, concepts and notes         |


## Install

`yarn` to install dependencies

## Development builds

`yarn circom:dev` to build deterministic development circuits.

Further, for debugging purposes, you may wish to inspect the intermediate files. This is possible with the `--debug` flag which the `circom:dev` task enables by default. You'll find them (by default) in `artifacts/circom/`

To build a single circuit during development, you can use the `--circuit` CLI parameter. For example, if you make a change to `hash.circom` and you want to _only_ rebuild that, you can run `yarn circom:dev --circuit hash`.

## Production builds

`yarn circom:prod` for production builds (using `Date.now()` as entropy)
