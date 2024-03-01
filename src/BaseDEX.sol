// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DecentralizedExchange {
    mapping(address => mapping(address => uint)) public balances;
    mapping(address => bool) public supportedTokens;
    uint public feePercentage = 1; // 1% fee

    event Trade(
        address indexed tokenIn,
        uint amountIn,
        address indexed tokenOut,
        uint amountOut
    );

    function addLiquidity(address token, uint amount) external {
        supportedTokens[token] = true;
        balances[msg.sender][token] += amount;
    }

    function removeLiquidity(address token, uint amount) external {
        require(balances[msg.sender][token] >= amount, "Insufficient balance");
        balances[msg.sender][token] -= amount;
    }

    function swap(address tokenIn, uint amountIn, address tokenOut) external {
        require(
            supportedTokens[tokenIn] && supportedTokens[tokenOut],
            "Tokens not supported"
        );
        require(
            balances[msg.sender][tokenIn] >= amountIn,
            "Insufficient balance"
        );

        uint feeAmount = (amountIn * feePercentage) / 100;
        uint amountOut = amountIn - feeAmount;

        balances[msg.sender][tokenIn] -= amountIn;
        balances[msg.sender][tokenOut] += amountOut;

        emit Trade(tokenIn, amountIn, tokenOut, amountOut);
    }
}
