// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {StdInvariant} from "forge-std/StdInvariant.sol";
import {DeployDSC} from "../../script/DeployDSC.s.sol";
import {DSCEngine} from "../../src/DSCEngine.sol";
import {DecentralizedStableCoin} from "../../src/DecentralizedStableCoin.sol";
import {HelperConfig} from "../../script/HelperConfig.s.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Handler} from "./Handler.t.sol";

contract Invariants is StdInvariant, Test {
    DeployDSC deployer;
    DecentralizedStableCoin dsc;
    DSCEngine dsce;
    HelperConfig helperConfig;
    address weth;
    address wbtc;
    Handler handler;

    function setUp() external {
        deployer = new DeployDSC();
        (dsc, dsce, helperConfig) = deployer.run();
        (,, weth, wbtc,) = helperConfig.activeNetworkConfig();
        // targetContract(address(dsce));
        handler = new Handler(dsce,dsc);
        targetContract(address(handler));
    }

    function invariant_protocalMustHaveMoreValueThanTotalSupply() public view {
        uint256 totalSupply = dsc.totalSupply(); // 0
        uint256 totalWethDeposited = IERC20(weth).balanceOf(address(dsce)); // 0
        uint256 totalWbtcDeposited = IERC20(wbtc).balanceOf(address(dsce)); // 0

        uint256 totalValue = dsce.getUsdValue(weth, totalWethDeposited) + dsce.getUsdValue(wbtc, totalWbtcDeposited);

        console.log("weth value: ", weth);
        console.log("wbtc value: ", wbtc);
        console.log("total supply: ", totalSupply);
        console.log("Times mint called: ", handler.timesMintIsCalled());

        assert(totalValue >= totalSupply);
    }

    function invariant_gettersShouldNotRevert() public view {
        dsce.getLiquidationBonus();
        dsce.getPrecision();
        // ... rest of the getters
    }
}
