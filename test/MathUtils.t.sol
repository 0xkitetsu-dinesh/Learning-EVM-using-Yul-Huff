// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {MathUtils} from "src/MathUtils.sol";
import "foundry-huff/HuffDeployer.sol";
import "src/IMathUtilsHuff.sol";

contract MathUtilsTest is Test {
    MathUtils internal math;
    IMathUtilsHuff internal mathUtilsHuff;
    uint256 start_index ;
    uint256 end_index ;

    function setUp() public {
        try vm.envUint("FOUNDRY_START_INDEX") returns (uint256 res) {
            start_index = res;
        } catch {
            start_index = 0;
        }
        try vm.envUint("FOUNDRY_END_INDEX") returns (uint256 res) {
            end_index = res;
        } catch {
            end_index = 50;
        }
        math = new MathUtils();
        mathUtilsHuff = IMathUtilsHuff(HuffDeployer.deploy("MathUtilsHuff"));
    }

    function testFuzz_Factorial(uint256 num) public {
        vm.assume(num>0);
        vm.assume(num<58);
        console.log(num,math.factorial(num));
    }

    

    function testFactorial_GasComparison() public {
        // uint256 num = 5;
        // loading two contracts here to neglect 
        math.factorial(start_index);
        mathUtilsHuff.factorial(start_index);
        uint256 gasLeft;
        uint256 gasCost_SolFactorial;
        uint256 gasCost_YulFactorial;
        uint256 gasCost_HuffFactorial;
        uint256 res1;uint256 res2;uint256 res3;
        console.log("------ Factorial Gas Comparision ----------");
        console.log("n, Sol,  Yul,  Huff");
        for(uint256 num=start_index;num<=end_index;num++){

            gasLeft = gasleft();
            // assigning to a variable costs 3 gas
            res1 = math.factorial(num);
            gasCost_SolFactorial = gasLeft - gasleft();
            gasLeft = gasleft();
            res2 = math.factorial_Yul(num);
            gasCost_YulFactorial = gasLeft - gasleft();
            gasLeft = gasleft();
            res3 = mathUtilsHuff.factorial(num);
            gasCost_HuffFactorial = gasLeft - gasleft();

            console.log(num,gasCost_SolFactorial-3,gasCost_YulFactorial-3,gasCost_HuffFactorial-3);
            assert(res1 == res2);
            assert(res2 == res3);
        }
    }

    function testSquare_GasComparison() public {
        math.square(start_index);
        mathUtilsHuff.square(start_index);
        uint256 gasLeft;
        uint256 gasCost_SolSquare;
        uint256 gasCost_YulSquare;
        uint256 gasCost_HuffSquare;
        uint256 res1;uint256 res2;uint256 res3;
        console.log("------------------Square Gas Comparision -----------------");
        console.log("n, Sol,  Yul,  Huff");
        for(uint256 num=start_index;num<=end_index;num++){
            gasLeft = gasleft();
            res1 = math.square(num);
            gasCost_SolSquare = gasLeft - gasleft();
            gasLeft = gasleft();
            res2 = math.square_Yul(num);
            gasCost_YulSquare = gasLeft - gasleft();
            gasLeft = gasleft();
            res3 = mathUtilsHuff.square(num);
            gasCost_HuffSquare = gasLeft - gasleft();

            console.log(num,gasCost_SolSquare-3,gasCost_YulSquare-3,gasCost_HuffSquare-3);
            assert(res1 == res2);
            assert(res2 == res3);

        }
    }
}
