# 智能合约学习项目

这是一个基于 Solidity 的智能合约学习项目，包含多个课程模块，涵盖了从基础到高级的智能合约开发概念。

## 项目结构

```
denglian/
├── go.mod                    # Go 模块文件
├── lession_1/               # 第一课：Go 基础练习
│   ├── question_1/
│   │   └── question_1.go
│   ├── question_2/
│   │   └── question_2.go
│   └── question_3/
├── lession_2/               # 第二课：基础智能合约
│   └── my_contract.sol
├── lession_3/               # 第三课：银行合约
│   └── bank.sol
├── lession_4/               # 第四课：高级银行合约系统
│   └── BigBank.sol
└── README.md
```

## 课程内容

### 第一课 (lession_1) - Go 基础练习
- **question_1**: Go 语言基础语法练习
- **question_2**: Go 语言进阶概念练习
- **question_3**: Go 语言实战应用

### 第二课 (lession_2) - 基础智能合约
- **my_contract.sol**: 简单的智能合约示例，介绍 Solidity 基础语法和概念

### 第三课 (lession_3) - 银行合约
- **bank.sol**: 基础银行合约，实现存款、取款、余额查询等功能

### 第四课 (lession_4) - 高级银行合约系统 ⭐

这是项目的核心部分，实现了一个完整的银行合约系统，包含以下特性：

#### 合约架构

1. **IBank 接口** - 定义银行合约的标准接口
2. **Bank 合约** - 基础银行合约，实现 IBank 接口
3. **BigBank 合约** - 继承自 Bank，添加高级功能
4. **Admin 合约** - 管理员合约，用于资金管理

#### 主要功能

##### Bank 合约功能
- ✅ 存款功能 (`deposit()`)
- ✅ 取款功能 (`withdraw()`)
- ✅ 余额查询 (`getBalance()`)
- ✅ 排行榜功能 (`getTop3()`)
- ✅ 自动接收 ETH (`receive()`)

##### BigBank 合约增强功能
- 🔒 **最小存款限制**: 存款金额必须 > 0.001 ether
- 👑 **管理员转移**: 支持转移管理员权限
- 🛡️ **权限控制**: 使用 modifier 进行权限验证

##### Admin 合约功能
- 👤 **Owner 管理**: 拥有独立的 Owner 权限
- 💰 **资金提取**: 可以从其他银行合约提取资金
- 🔄 **接口调用**: 通过 IBank 接口调用其他合约

#### 技术特性

- **继承机制**: BigBank 继承自 Bank 合约
- **接口实现**: Bank 实现 IBank 接口
- **修饰符使用**: 使用 modifier 进行权限控制
- **事件处理**: 支持 ETH 自动接收
- **安全验证**: 多重安全检查机制

## 使用指南

### 环境要求

- Solidity ^0.8.0
- 支持 EVM 的区块链网络（如 Ethereum、Polygon、BSC 等）
- Web3 开发环境（如 Remix、Hardhat、Truffle 等）

### 部署步骤

1. **部署 Admin 合约**
   ```solidity
   // 部署 Admin 合约，记录合约地址
   Admin adminContract = new Admin();
   ```

2. **部署 BigBank 合约**
   ```solidity
   // 部署 BigBank 合约
   BigBank bigBank = new BigBank();
   ```

3. **转移管理员权限**
   ```solidity
   // 将 BigBank 的管理员转移给 Admin 合约
   bigBank.transferAdmin(address(adminContract));
   ```

4. **模拟用户存款**
   ```solidity
   // 用户存款（金额必须 > 0.001 ether）
   bigBank.deposit{value: 0.002 ether}();
   ```

5. **提取资金到 Admin 合约**
   ```solidity
   // Admin 合约的 Owner 调用
   adminContract.adminWithdraw(bigBank);
   ```

6. **最终资金提取**
   ```solidity
   // Owner 将 Admin 合约中的资金提取到自己的地址
   adminContract.withdrawAdminBalance();
   ```

### 合约交互示例

```javascript
// 使用 Web3.js 与合约交互
const bigBank = new web3.eth.Contract(BigBankABI, bigBankAddress);
const admin = new web3.eth.Contract(AdminABI, adminAddress);

// 存款
await bigBank.methods.deposit().send({
    from: userAddress,
    value: web3.utils.toWei('0.002', 'ether')
});

// 转移管理员
await bigBank.methods.transferAdmin(adminAddress).send({
    from: deployerAddress
});

// 提取资金
await admin.methods.adminWithdraw(bigBankAddress).send({
    from: ownerAddress
});
```

## 安全考虑

- ✅ 权限验证：所有关键操作都有权限检查
- ✅ 金额验证：存款金额有最小限制
- ✅ 余额检查：取款前检查合约余额
- ✅ 地址验证：确保地址有效性
- ✅ 重入攻击防护：使用 transfer 而非 call

## 开发建议

1. **测试优先**: 在部署到主网前，务必在测试网进行充分测试
2. **代码审计**: 建议进行专业的智能合约安全审计
3. **升级机制**: 考虑添加合约升级机制
4. **事件记录**: 可以添加更多事件来记录重要操作
5. **Gas 优化**: 优化合约代码以减少 Gas 消耗

## 许可证

MIT License

## 贡献

欢迎提交 Issue 和 Pull Request 来改进这个项目！

---

**注意**: 这是一个学习项目，在生产环境中使用前请进行充分的安全测试和审计。
