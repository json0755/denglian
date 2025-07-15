// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; // 指定Solidity编译器版本

import "./TokenBank.sol"; // 导入TokenBank合约
import "./BaseERC20.sol"; // 导入BaseERC20合约和ITokenReceiver接口

// TokenBankV2 继承 TokenBank，并实现 ITokenReceiver
contract TokenBankV2 is TokenBank, ITokenReceiver {
    constructor(address tokenAddress) TokenBank(tokenAddress) {} // 构造函数，初始化TokenBank

    // 实现 tokensReceived，供扩展 ERC20 Token 回调
    function tokensReceived(address from, uint256 amount) external override { // 回调函数，接收Token时调用
        require(msg.sender == address(token), unicode"只接受指定Token的回调"); // 只允许指定Token合约回调
        require(amount > 0, unicode"存入数量必须大于0"); // 检查存入数量
        balances[from] += amount; // 增加用户在银行的存款记录
    }
}