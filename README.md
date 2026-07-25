# SpecCanon-boot

> 在当前目录快速创建 SpecCanon 模板项目，一句话完成初始化。

## 一行命令（手动用）

```bash
# 先进到你的项目目录
cd ~/projects/photo-app

# 一键创建骨架 + git init
curl -fsSL https://raw.githubusercontent.com/Toketec/SpecCanon-boot/main/init.sh | bash -s new

# 也可以指定项目名
curl ... | bash -s new "学校照片SaaS"

# 或指定路径
curl ... | bash -s new ../photo-app "学校照片SaaS"

# 给现有项目嵌入骨架
curl ... | bash -s migrate
```

## Hermes Agent（AI 用）

```bash
hermes curator install https://github.com/Toketec/SpecCanon-boot
```

然后在对话中说：

```
spec-canon-boot new
```

AI 会：
1. ✅ 在当前目录创建骨架 + git init
2. ✅ 如果需求清晰 → 帮你写 `product-overview.md` 和 `sprint`
3. ✅ 如果需求不清晰 → 停，问你做什么项目

## 安装

```bash
hermes curator install https://github.com/Toketec/SpecCanon-boot
```

## License

MIT
