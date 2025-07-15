// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 声明合约 BaseERC20，继承自 ERC20 标准接口
contract BaseERC20 {
    // 代币名称
    string public name = "BaseERC20 Token";
    // 代币符号
    string public symbol = "BET";
    // 代币小数位数
    uint8 public decimals = 18;
    // 代币总供应量
    uint256 public totalSupply;
    // 记录每个地址的余额
    mapping(address => uint256) public balanceOf;
    // 记录授权信息：owner => (spender => amount)
    mapping(address => mapping(address => uint256)) public allowance;

    // 构造函数，初始化总供应量并分配给部署者
    constructor(uint256 _initialSupply) {
        totalSupply = _initialSupply;
        balanceOf[msg.sender] = _initialSupply;
    }

    // 转账函数，向指定地址转账指定数量的代币
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value, unicode"余额不足");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        return true;
    }

    // 授权函数，允许spender从msg.sender账户转走指定数量的代币
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        return true;
    }

    // 代理转账函数，spender可以从from账户转账到to账户
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[_from] >= _value, unicode"余额不足");
        require(allowance[_from][msg.sender] >= _value, unicode"授权额度不足");
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        return true;
    }
}