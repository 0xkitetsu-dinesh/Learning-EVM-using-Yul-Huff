# Gas Optimizations / Gas Golfing using Huff , Yul
 - Huff being a low-level programming language, can be used to optimize Smart Contract (which results in less computation cost than Yul and Solidity).

 - Square using Huff
    - <img src = "Square_GasReport.png"/>

 - Factorial using Huff
   - `50!` using `Huff` consumes `15%` less gas than `Solidity`
   - <img src = "Factorial_GasReport.png"/>
   -  `"solc = 0.8.15; optimizer = true; optimizer_runs = 10000; via-ir = true" `
   - <img src = "Factorial_GasReportV2.png"/>
