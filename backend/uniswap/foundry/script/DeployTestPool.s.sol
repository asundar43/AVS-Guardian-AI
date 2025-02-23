// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Script.sol";
import "../contracts/UniswapV4Pool.sol";

contract DeployTestPool is Script {
    function run() external {
        // Start broadcasting transactions. This uses your PRIVATE_KEY and RPC_URL.
        vm.startBroadcast();

        // Deploy the DummyPool contract.
        TestPool testPool = new TestPool();

        // Stop broadcasting.
        vm.stopBroadcast();

        // Log the deployed contract address.
        console.log("DummyPool deployed at:", address(testPool));
    }
}