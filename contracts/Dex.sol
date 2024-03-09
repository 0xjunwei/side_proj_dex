// SPDX-License-Identifier: MIT
// Not building a library thus set a version do not use ^
pragma solidity 0.8.24;

contract Dex {
    struct LPbalance {
        address depositorAddress;
        uint256 liquidityAmount;
    }

    struct Pool {
        address tokenA;
        address tokenB;
        uint256 tokenA_AmountInPool;
        uint256 tokenB_AmountInPool;
        // X * Y = Z value total
        uint256 xyVal;
        LPbalance[] depositors;
        uint256 poolIndex;
    }
    mapping(address => mapping(address => bool)) poolExists;
    mapping(address => mapping(address => uint256)) poolIndex;
    Pool[] pools;
    uint256 currPoolIndex = 0;

    function addPool(
        address _tokenIn,
        address _tokenOut,
        uint256 _tokenAIn,
        uint256 _tokenBIn
    ) public {
        // Check if pool exist
        if (poolExists[_tokenIn][_tokenOut]) {} else {
            pools.push(
                Pool({
                    tokenA: _tokenIn,
                    tokenB: _tokenOut,
                    tokenA_AmountInPool: _tokenAIn,
                    tokenB_AmountInPool: _tokenBIn,
                    xyVal: 0,
                    depositors: new LPbalance[](0),
                    poolIndex: currPoolIndex
                })
            );
            // Add sender address and liquidity amount to the depositors array
            pools[currPoolIndex].depositors.push(
                LPbalance({
                    depositorAddress: msg.sender,
                    liquidityAmount: _tokenAIn * _tokenBIn
                })
            );
            poolExists[_tokenIn][_tokenOut] = true;
            currPoolIndex += 1;
        }
    }
}
