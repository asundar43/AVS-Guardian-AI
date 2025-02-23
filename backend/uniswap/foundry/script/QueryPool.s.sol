// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Script.sol";
// Import the TestPool contract directly
import "../contracts/UniswapV4Pool.sol";

contract QueryPool is Script {
    // The run() function is the entry point when the script is executed.
    function run() external {
        // Read the pool address from environment variable (POOL_ADDRESS)
        address poolAddress = vm.envAddress("POOL_ADDRESS");
        require(poolAddress != address(0), "Pool address not set");

        // Create an instance of the TestPool contract.
        TestPool pool = TestPool(poolAddress);

        // Call slot0() to get the pool's key parameters.
        (
            uint160 sqrtPriceX96,
            int24 tick,
            uint16 observationIndex,
            uint16 observationCardinality,
            uint16 observationCardinalityNext,
            uint8 feeProtocol,
            bool unlocked
        ) = pool.slot0();

        // Get liquidity
        uint128 liquidity = pool.liquidity();

        // Log the fetched data
        console.log("Pool slot0:");
        console.log("  sqrtPriceX96:", sqrtPriceX96);
        console.log("  tick:", tick);
        console.log("  observationIndex:", observationIndex);
        console.log("  observationCardinality:", observationCardinality);
        console.log("  observationCardinalityNext:", observationCardinalityNext);
        console.log("  feeProtocol:", feeProtocol);
        console.log("  unlocked:", unlocked);
        console.log("Liquidity:", liquidity);
    }
}