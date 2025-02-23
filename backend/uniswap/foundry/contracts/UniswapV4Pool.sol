// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract TestPool {
    uint160 public sqrtPriceX96 = 79228162514264337593543950336; // example value
    int24 public tick = 0;
    uint16 public observationIndex = 1;
    uint16 public observationCardinality = 1;
    uint16 public observationCardinalityNext = 1;
    uint8 public feeProtocol = 1;
    bool public unlocked = true;
    uint128 public liquidity = 1000000;

    // Mimic the Uniswap V4 pool's slot0 function
    function slot0() external view returns (
        uint160, int24, uint16, uint16, uint16, uint8, bool
    ) {
        return (
            sqrtPriceX96,
            tick,
            observationIndex,
            observationCardinality,
            observationCardinalityNext,
            feeProtocol,
            unlocked
        );
    }
}