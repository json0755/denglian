# 区块链学习项目

本项目用于区块链相关知识的学习与实践，涵盖了工作量证明（POW）、哈希算法、公私钥生成、数字签名与验证等基础内容，以及Solidity智能合约的编写与部署，适合区块链初学者自学和参考。

## 目录结构

```
├── combat_1/                 # 第一阶段 Go 实战代码
│   ├── combat_1_1.go         # POW 算法实践
│   └── combat_1_2.go         # 公私钥生成、签名与验证实践
├── lession_2/                # 第二阶段 Solidity 智能合约
│   └── my_contract.sol       # Counter 智能合约示例
├── go.mod                    # Go 依赖管理文件
├── main.go                   # Go 入口文件（可选）
└── README.md                 # 项目说明文档
```

## 主要学习内容

### Go 语言部分
- SHA256 哈希算法的使用
- POW（工作量证明）机制实现
- ECDSA 公私钥对生成
- 使用私钥对数据签名
- 使用公钥验证签名
- Go 语言基础语法与实践

### Solidity 智能合约部分
- 智能合约基础语法
- Counter 合约的编写与部署
  - 状态变量 counter
  - get() 方法：获取 counter 的值
  - add(x) 方法：给 counter 加上 x
- Remix IDE 的使用与以太坊测试网部署

## 运行方法

### Go 代码
1. **环境要求**
   - Go 1.18 及以上版本
2. **运行示例代码**
   ```sh
   go run combat_1/combat_1_1.go
   go run combat_1/combat_1_2.go
   ```

### Solidity 合约
1. 打开 [Remix IDE](https://remix.ethereum.org/)
2. 新建文件，将 `lession_2/my_contract.sol` 内容粘贴进去
3. 编译合约，部署到任意以太坊测试网（如 Goerli、Sepolia 等）
4. 在 Remix 的部署面板中调用 `get()` 和 `add(x)` 方法进行测试

## 参考资料
- [比特币白皮书](https://bitcoin.org/bitcoin.pdf)
- [Go 官方文档](https://golang.org/doc/)
- [区块链原理与实现](https://learnblockchain.cn/)
- [Solidity 官方文档](https://docs.soliditylang.org/)
- [Remix IDE](https://remix.ethereum.org/)

---

如有问题或建议，欢迎 issue 或 PR！祝你学习愉快！
