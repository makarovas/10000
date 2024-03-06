include "poseidon.circom";

template Main() {
    signal private input secret;
    signal private input bid;
    signal input hash;
    signal output isValid;

    component hashCheck = Poseidon(2);
    hashCheck.inputs[0] <== secret;
    hashCheck.inputs[1] <== bid;
    isValid <== hashCheck.out === hash;
}

component main = Main();
