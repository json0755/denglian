package main

import (
	"crypto/ecdsa"
	"crypto/elliptic"
	"crypto/rand"
	"crypto/sha256"
	"encoding/hex"
	"fmt"
	"strconv"
	"strings"
)

//实践非对称加密 RSA（编程语言不限）：
//1.先生成一个公私钥对
//2.用私钥对符合 POW 4 个 0 开头的哈希值的 “昵称 + nonce” 进行私钥签名
//3.用公钥验证

// powWithLeadingZeros 寻找满足前n个0的哈希值
func powWithLeadingZeros(nickname string, zeros int) (content string) {
	prefix := strings.Repeat("0", zeros)
	for nonce := 0; ; nonce++ {
		content = nickname + strconv.Itoa(nonce)
		hash := sha256.Sum256([]byte(content))
		hashStr := hex.EncodeToString(hash[:])
		if strings.HasPrefix(hashStr, prefix) {
			return
		}
	}
}

func main() {
	nickname := "bape" // 你的昵称

	// 1. 生成ECDSA公私钥对
	privateKey, err := ecdsa.GenerateKey(elliptic.P256(), rand.Reader)
	if err != nil {
		panic(err)
	}
	publicKey := &privateKey.PublicKey
	fmt.Println("公私钥对已生成！")

	// 2. POW: 找到前4个0的哈希值
	content := powWithLeadingZeros(nickname, 4)
	fmt.Printf("找到满足4个0的内容: %s\n", content)

	// 3. 用私钥对内容签名
	hash := sha256.Sum256([]byte(content))
	//在 ECDSA（椭圆曲线数字签名算法）中，ecdsa.Sign 方法返回的 r 和 s 是构成数字签名的两个大整数。具体来说：
	//r：它是椭圆曲线上某个点的 x 坐标，模曲线的阶（order）后得到的结果。在签名生成过程中，首先会选择一个随机数 k，
	//计算 k 乘以曲线的基点 G，得到点 (x, y)，然后 r 就是 x mod n（n 是曲线的阶）
	//它的计算涉及私钥、哈希值和随机数 k，公式为 s = k⁻¹ * (hash + privateKey * r) mod n，其中 k⁻¹ 是 k 的模逆元。
	//签名验证时，验证方会使用公钥、消息哈希、r 和 s 来确认签名的有效性。r 和 s 共同保证了签名的完整性和不可否认性。
	r, s, err := ecdsa.Sign(rand.Reader, privateKey, hash[:])
	if err != nil {
		panic(err)
	}
	fmt.Printf("签名完成!\nr: %s\ns: %s\n", r.String(), s.String())

	// 4. 用公钥验证签名
	valid := ecdsa.Verify(publicKey, hash[:], r, s)
	if valid {
		fmt.Println("签名验证成功！")
	} else {
		fmt.Println("签名验证失败！")
	}
}
