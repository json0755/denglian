# 区块链学习项目

本项目用于区块链相关知识的学习与实践，涵盖了工作量证明（POW）、哈希算法、公私钥生成、数字签名与验证等基础内容，适合区块链初学者自学和参考。

## 目录结构

```
├── combat_1/           # 第一阶段实战代码
│   ├── combat_1_1.go   # POW 算法实践
│   └── combat_1_2.go   # 公私钥生成、签名与验证实践
├── go.mod              # Go 依赖管理文件
├── main.go             # 入口文件（可选）
└── README.md           # 项目说明文档
```

## 主要学习内容

- SHA256 哈希算法的使用
- POW（工作量证明）机制实现
- ECDSA 公私钥对生成
- 使用私钥对数据签名
- 使用公钥验证签名
- Go 语言基础语法与实践

## 运行方法

1. **环境要求**
   - Go 1.18 及以上版本
   - 推荐使用 VSCode 或 Goland 编辑器

2. **运行示例代码**
   进入对应目录，执行：
   ```sh
   go run combat_1/combat_1_1.go
   go run combat_1/combat_1_2.go
   ```

3. **编译可执行文件**
   ```sh
   go build -o pow_demo combat_1/combat_1_1.go
   ./pow_demo
   ```

## 参考资料
- [比特币白皮书](https://bitcoin.org/bitcoin.pdf)
- [Go 官方文档](https://golang.org/doc/)
- [区块链原理与实现](https://learnblockchain.cn/)

---

如有问题或建议，欢迎 issue 或 PR！祝你学习愉快！
