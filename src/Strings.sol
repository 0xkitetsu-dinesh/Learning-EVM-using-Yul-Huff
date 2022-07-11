// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// https://docs.soliditylang.org/en/v0.8.15/internals/layout_in_storage.html#bytes-and-string
contract StoragePattern{

    string public word = "angle";
    string public word_GT31 = "The quick fox jumped over lazy dog";

    function WordInStorage() public view returns (bytes32){
        // for short string (length shorter than 32 ) the string are stored together with the length in the same slot
        assembly {
            mstore(0,sload(word.slot))
            return(0,0x20)
        }
    }

    function WordGT31InStorage() public view returns (bytes32,bytes32,bytes32){
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
            // since string length is 34, 2 slots are used to store the string in Storage
            mstore(add(free_ptr,0x40),sload(add(word_ptr,0x01)))
            
            return(free_ptr,0x60)
        }
    }
}