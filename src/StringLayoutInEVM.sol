// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// https://docs.soliditylang.org/en/v0.8.15/internals/layout_in_storage.html#bytes-and-string
contract StringLayout{

    string public word = "angle";
    string public word_GT31 = "The quick brown fox jumped over lazy dog";

    function WordInStorage() public view returns (bytes32,bytes32 length){
        // for short string (length shorter than 32 ) the string are stored together with the length in the same slot
        assembly {
            let free_ptr := mload(0x40)
            mstore(free_ptr,sload(word.slot))
            //copy length of the string
            mstore(add(free_ptr,0x20),shr(1,and(sload(word.slot),0xFF)))
            return(free_ptr,0x40)
        }
    }

    function WordGT31InStorage() public view returns (bytes32 length,bytes32,bytes32,bytes32){
        assembly {
            let free_ptr := mload(0x40)
            // For larger string , length would be available at slot(`p`) allocated to `word_GT31`
            // load string length to first available memory slot
            mstore(free_ptr,sload(word_GT31.slot))

            // To find data of word_GT31
            // load slot `p` in scratch space 
            mstore(0,word_GT31.slot)
            let word_ptr := keccak256(0,0x20)
            mstore(add(free_ptr,0x20),sload(word_ptr))
            // since string length is 40, 2 slots are used to store the string in Storage
            mstore(add(free_ptr,0x40),sload(add(word_ptr,0x01)))
            //copy length of the string 
            mstore(add(free_ptr,0x60),shr(1,and(sload(word_GT31.slot),0xFF)))
            return(free_ptr,0x80)
        }
    }
}