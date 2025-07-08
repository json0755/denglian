package main

import (
	"crypto/sha256"
	"encoding/hex"
	"fmt"
	"strconv"
	"strings"
	"time"
)

//实践 POW， 编写程序（编程语言不限）用自己的昵称 + nonce，不断修改nonce 进行 sha256 Hash 运算：
//
//直到满足 4 个 0 开头的哈希值，打印出花费的时间、Hash 的内容及Hash值。
//再次运算直到满足 5 个 0 开头的哈希值，打印出花费的时间、Hash 的内容及Hash值。
//
//给出完整相应的代码和注释

// 实现POW算法，找到满足前n个0的哈希值
func powWithLeadingZeros(nickname string, zeros int) (nonce int, hashStr string, content string, duration time.Duration) {
	prefix := strings.Repeat("0", zeros)
	start := time.Now()
	for nonce = 0; ; nonce++ {
		content = nickname + strconv.Itoa(nonce)
		hash := sha256.Sum256([]byte(content))
		hashStr = hex.EncodeToString(hash[:])
		if strings.HasPrefix(hashStr, prefix) {
			duration = time.Since(start)
			return
		}
	}
}

func main() {
	nickname := "bape" // 你的昵称

	// 第一次：找到前4个0的哈希值
	_, hash4, content4, duration4 := powWithLeadingZeros(nickname, 4)
	fmt.Printf("[4个0] 用时: %v\n内容: %s\nHash: %s\n\n", duration4, content4, hash4)

	// 第二次：找到前5个0的哈希值
	_, hash5, content5, duration5 := powWithLeadingZeros(nickname, 5)
	fmt.Printf("[5个0] 用时: %v\n内容: %s\nHash: %s\n", duration5, content5, hash5)

	// 第三次：找到前6个0的哈希值
	_, hash6, content6, duration6 := powWithLeadingZeros(nickname, 6)
	fmt.Printf("[6个0] 用时: %v\n内容: %s\nHash: %s\n", duration6, content6, hash6)

	// 第四次：找到前7个0的哈希值
	_, hash7, content7, duration7 := powWithLeadingZeros(nickname, 7)
	fmt.Printf("[7个0] 用时: %v\n内容: %s\nHash: %s\n", duration7, content7, hash7)

	// 第五次：找到前8个0的哈希值
	_, hash8, content8, duration8 := powWithLeadingZeros(nickname, 8)
	fmt.Printf("[8个0] 用时: %v\n内容: %s\nHash: %s\n", duration8, content8, hash8)
}
