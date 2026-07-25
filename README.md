# SpecCanon-boot

> `/spec-canon` — 快速建空壳、嵌入骨架、预览项目全貌。

## 子命令

```
spec-canon init [项目名]    → 建空壳 + git init（核心）
spec-canon migrate          → 嵌入骨架到现有项目
spec-canon preview          → 生成项目可视化预览页
```

## 一行命令（手动用）

```bash
cd ~/projects/photo-app

# 建空壳
curl -fsSL https://raw.githubusercontent.com/Toketec/SpecCanon-boot/main/spec-canon | bash -s init

# 指定项目名
curl ... | bash -s init "学校照片SaaS"

# 嵌入骨架
curl ... | bash -s migrate

# 可视化预览（在浏览器打开 docs/preview.html）
curl ... | bash -s preview
```

## Hermes Agent

```bash
hermes curator install https://github.com/Toketec/SpecCanon-boot
```

对话中：

```
/spec-canon init "学校照片SaaS"
/spec-canon migrate
/spec-canon preview
```

## 安装

```bash
hermes curator install https://github.com/Toketec/SpecCanon-boot
```

## License

MIT
