// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AMMSmartContract {
    mapping(address => uint) public balances;
    event Swap(
        address indexed tokenIn,
        uint amountIn,
        address indexed tokenOut,
        uint amountOut
    );

    constructor() {}

    function addLiquidity(uint _amount) external {
        balances[msg.sender] += _amount;
    }

    function removeLiquidity(uint _amount) external {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
    }

    function swap(address tokenIn, uint amountIn, address tokenOut) external {
        require(balances[msg.sender] >= amountIn, "Insufficient balance");
        uint amountOut = amountIn;
        balances[msg.sender] -= amountIn;
        balances[tokenOut] += amountOut;
        emit Swap(tokenIn, amountIn, tokenOut, amountOut);
    }
}
