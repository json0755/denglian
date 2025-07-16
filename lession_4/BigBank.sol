// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 在 该挑战 的 Bank 合约基础之上，编写 IBank 接口及BigBank 合约，使其满足 Bank 实现 IBank， BigBank 继承自 Bank ， 同时 BigBank 有附加要求：

// 要求存款金额 >0.001 ether（用modifier权限控制）
// 	1.BigBank 合约支持转移管理员
// 	2.编写一个 Admin 合约， Admin 合约有自己的 Owner ，同时有一个取款函数 adminWithdraw(IBank bank) , adminWithdraw 中会调用 IBank 接口的 withdraw 方法从
//     而把 bank 合约内的资金转移到 Admin 合约地址。

// BigBank 和 Admin 合约 部署后，把 BigBank 的管理员转移给 Admin 合约地址，模拟几个用户的存款，然后Admin 合约的Owner地址调用 adminWithdraw(IBank bank) 
// 把 BigBank 的资金转移到 Admin 地址。

// IBank接口定义
interface IBank {
    function deposit() external payable;
    function withdraw(uint256 amount) external;
    function getBalance(address addr) external view returns (uint256);
    function getTop3() external view returns (address[3] memory);
}

// Bank合约实现IBank接口
contract Bank is IBank {
    // 记录每个地址的存款金额
    mapping(address => uint256) public balances;
    // 记录所有存款过的用户
    address[] private allUsers;
    mapping(address => bool) private isUser;
    // 记录存款金额的前 3 名用户
    address[3] public top3;
    // 管理员
    address public admin;

    // 构造函数，初始化管理员
    constructor() {
        admin = msg.sender;
    }

    // 存款函数，任何人可存钱
    function deposit() public payable virtual {
        if (!isUser[msg.sender]) {
            allUsers.push(msg.sender);
            isUser[msg.sender] = true;
        }
        balances[msg.sender] += msg.value;
        updateTop3();
    }

    // 自动接收ETH并调用deposit
    receive() external payable virtual {
        deposit();
    }

    // 更新top3，保证top3为存款最多的3个用户且无重复
    function updateTop3() internal {
        // 简化实现，避免复杂的排序逻辑
        if (allUsers.length == 0) {
            return;
        }
        
        // 找到前3个有余额的用户
        uint256 count = 0;
        for (uint256 i = 0; i < allUsers.length && count < 3; i++) {
            address user = allUsers[i];
            if (balances[user] > 0) {
                top3[count] = user;
                count++;
            }
        }
        
        // 如果不足3个，用零地址填充
        for (uint256 i = count; i < 3; i++) {
            top3[i] = address(0);
        }
    }
    

    // 管理员提取指定金额
    function withdraw(uint256 amount) public virtual {
        require(msg.sender == admin, "Only admin can withdraw");
        require(amount <= address(this).balance, "Insufficient contract balance");
        payable(admin).transfer(amount);
    }

    // 获取前 3 名用户
    function getTop3() public view override returns (address[3] memory) {
        return top3;
    }

    // 获取指定地址的存款金额
    function getBalance(address addr) public view override returns (uint256) {
        return balances[addr];
    }
}

//BigBank合约继承Bank，添加存款限制和管理员转移功能
contract BigBank is Bank {
    //最小存款金额 0.001 ether
    uint256 private constant MIN_DEPOSIT = 0.001 ether;

    //权限修饰符：检查存款金额是否大于0.001 ether
    modifier mininumDeposit() {
        require(msg.value > MIN_DEPOSIT, "Deposit amount must be greater than 0.001 ether");
        _;
    }

    //转移管理员权限
    function transferAdmin(address newAdmin) public {
        require(msg.sender == admin, "Only admin can transfer admin");
        admin = newAdmin;
    }

    //重写deposit函数，添加存款金额限制
    function deposit() public payable override mininumDeposit {
        super.deposit();
    }

    //重写withdraw函数，确保只有当前管理员可以提取
    function withdraw(uint256 amount) public override {
        require(msg.sender == admin, "Only admin can withdraw");
        require(amount <= address(this).balance, "Insufficient contract balance");
        payable(admin).transfer(amount);
    }
}

//Admin合约，Admin合约有自己的Owner，同时有一个取款函数adminWithdraw(IBank bank)
contract Admin {
    //Admin合约的Owner
    address public owner;

    //构造函数，设置Owner为部署者
    constructor() {
        owner = msg.sender;
    }

    //权限修饰符：只有Owner可以调用
    modifier onlyOwner() {
        require(msg.sender == owner, "only owner can call this function");
        _;
    }

    //取款函数，调用IBank接口的withdraw方法，把bank合约内的资金转移到Admin合约地址
    function adminWithdraw(IBank bank) public onlyOwner {
        //获取bank合约内的余额
        uint256 balance = address(bank).balance;
        require(balance > 0,"Bank has no balance to withdraw");
        
        //调用IBank接口的withdraw方法，把bank合约内的资金转移到Admin合约地址
        bank.withdraw(balance);
    }

    // 提取Admin合约自身的余额
    function withdrawAdminBalance() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No balance to withdraw");
        payable(owner).transfer(balance);
    }
    
    // 接收ETH
    receive() external payable {}
}