// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 一个简单的计数器合约
//使用 Remix 创建一个 Counter 合约并部署到任意以太坊测试网:
// Counter 合约具有
// 1.一个状态变量 counter
// 2.get()方法: 获取 counter 的值
// 3.add(x) 方法: 给变量加上 x 。
contract Counter {
    // 1. 状态变量 counter
    uint256 private counter;

    // 构造函数，初始化 counter 为 0
    constructor() {
        counter = 0;
    }

    // 2. 获取 counter 的值
    function get() public view returns (uint256) {
        return counter;
    }

    // 3. 给 counter 加上 x
    function add(uint256 x) public {
        counter += x;
    }
}
