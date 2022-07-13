// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {StringLayout} from "src/StringLayoutInEVM.sol";

contract StringLayoutTest is Test {
    StringLayout internal stringLayout;
    function setUp() public {
        stringLayout = new StringLayout();
    }

    function testWordInStorage() public {
        bytes32 length;
        bytes32 b1;
        (b1,length) = stringLayout.WordInStorage();
        console.log("word `angle` in Storage");
        console.logBytes32(b1);
        console.log("length");
        console.logBytes32(length);
    }

    function testWordGT31InStorage() public {
        bytes32 length;
        bytes32 b1;
        bytes32 b2;
        bytes32 b3;
        console.log("word `The quick brown fox jumped over lazy dog` in Storage");
        (b1,b2,b3,length) = stringLayout.WordGT31InStorage();
        console.logBytes32(b1);
        console.logBytes32(b2);
        console.logBytes32(b3);
        console.log("length");
        console.logBytes32(length);
    }
}
