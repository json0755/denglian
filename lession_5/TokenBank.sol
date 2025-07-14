// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IBaseERC20 {
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function transfer(address to, uint256 amount) external returns (bool);
}

contract TokenBank {
    IBaseERC20 public token;
    mapping(address => uint256) public balances;

    constructor(address tokenAddress) {
        token = IBaseERC20(tokenAddress);
    }

    // 存入 Token
    function deposit(uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        require(token.transferFrom(msg.sender, address(this), amount), "transferFrom failed");
        balances[msg.sender] += amount;
    }

    // 提取 Token
    function withdraw(uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        require(token.transfer(msg.sender, amount), "transfer failed");
    }
}