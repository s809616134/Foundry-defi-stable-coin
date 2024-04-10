// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

/**
 * @title OracleLib
 * @author Edon
 * @notice This library is to check the Chainlink Oracle priceFeed
 * If price feed is stale, the function will reverts, and render the
 * DSCEngine unusable - this is by design
 *
 * We want the DSCEngine to freeze if prices become stalr
 * If the Chainlink network explodes, money will be locked in the protocal
 */
library OracleLib {
    error OracleLib__StalePrice();
    // heartbeat

    uint256 private constant TIMEOUT = 3 hours;

    function staleCheckLatestRoundData(AggregatorV3Interface priceFeed)
        public
        view
        returns (uint80, int256, uint256, uint256, uint80)
    {
        (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) =
            priceFeed.latestRoundData();

        // stale check

        uint256 secondsSince = block.timestamp - updatedAt;
        if (secondsSince > TIMEOUT) revert OracleLib__StalePrice();
        return (roundId, answer, startedAt, updatedAt, answeredInRound);
    }
}
