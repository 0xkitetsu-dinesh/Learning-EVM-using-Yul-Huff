// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {MathUtils} from "src/MathUtils.sol";

contract MathUtilsTest is Test {
    MathUtils internal math;

    function setUp() public {
        math = new MathUtils();
    }

    function testFuzz_Factorial(uint256 num) public {
        vm.assume(num>0);
        vm.assume(num<58);
        console.log(num,math.factorial(num));
    }
    uint256 start_index = 1;
    uint256 end_index = 5;
    function test_GasComparison_1_5() public {
        // uint256 num = 5;
        uint256 gasLeft;
        uint256 gasCost_SolidityFactorial;
        uint256 gasCost_YulFactorial;
        console.log("inp, gasCost_SolidityFactorial, gasCost_YulFactorial");
        for(uint256 num=start_index;num<=end_index;num++){

            gasLeft = gasleft();
            math.factorial(num);
            gasCost_SolidityFactorial = gasLeft - gasleft();
            gasLeft = gasleft();
            math.factorial_Yul(num);
            gasCost_YulFactorial = gasLeft - gasleft();

            console.log(num,gasCost_SolidityFactorial,gasCost_YulFactorial);
        }
    }

    function test_GasComparison_rev_5_1() public {
        // uint256 num = 5;
        uint256 gasLeft;
        uint256 gasCost_SolidityFactorial;
        uint256 gasCost_YulFactorial;
        console.log("inp, gasCost_SolidityFactorial, gasCost_YulFactorial");
        for(uint256 num=end_index;num>=start_index;num--){

            gasLeft = gasleft();
            math.factorial(num);
            gasCost_SolidityFactorial = gasLeft - gasleft();
            gasLeft = gasleft();
            math.factorial_Yul(num);
            gasCost_YulFactorial = gasLeft - gasleft();
            

            console.log(num,gasCost_SolidityFactorial,gasCost_YulFactorial);
        }
    }
}
