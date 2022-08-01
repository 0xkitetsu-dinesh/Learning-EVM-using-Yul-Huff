// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract MathUtils {
    // function sqrt(uint256 number) public returns()

    function square(uint256 x) public pure returns (uint256 ){
        return x * x;
    }

    function square_Yul(uint256 x) public pure returns (uint256 ){
        assembly{
            mstore(0,mul(x,x))
            return(0,0x20)
        }
    }

    // Factorial
    function factorial(uint256 x) public pure returns (uint256) {
        if (x == 0) {
            return 1;
        } else {
            return x * factorial(x - 1);
        }
    }

    // Factorial Using Yul - with assembly fn
    function factorial_Yul(uint256 x) public pure returns(uint256){
        assembly{
            function factorial(num) -> result{
                switch num
                case 0{
                    result:= 1
                }
                default{
                    result:= mul(num,factorial(sub(num,0x01)))
                }

            }
            mstore(0,factorial(x))
            return(0,0x20)
            // y := factorial(x)

        }
    }
    
    // https://twitter.com/leonardoalt/status/1553835565056942085
    // https://gist.github.com/leonardoalt/52693c9681faed3ddd60e96eed84b877
    function factorial_Yul_For(uint256 x) public pure returns(uint256){
        assembly{
            let result := 1
            for {} iszero(iszero(x)) { x := sub(x, 1)} {
                result := mul(result, x)
            }
            mstore(0,result)
            return(0,0x20)
        }
    }
}
