# SpecCanon-boot

> `/spec-canon` — 快速建空壳、引导写文档、嵌入骨架、预览全貌。

## 子命令

```
init          → 建空壳 + git init（核心）
brainstorm    → 引导你填充产品文档 + 创建 sprint
migrate       → 嵌入骨架到现有项目
preview       → 生成项目可视化预览页
```

## 一行命令（手动用）

```bash
cd ~/projects/photo-app

curl -fsSL https://raw.githubusercontent.com/Toketec/SpecCanon-boot/main/spec-canon | bash -s init
curl ... | bash -s brainstorm
curl ... | bash -s migrate
curl ... | bash -s preview
```

## Hermes Agent

安装：
```bash
hermes curator install https://github.com/Toketec/SpecCanon-boot
```

对话：
```
/spec-canon init "学校照片SaaS"
/spec-canon brainstorm
/spec-canon preview
```

## 完整使用路径

```
1. cd ~/projects/photo-app
2. /spec-canon init             → 建空壳
3. /spec-canon brainstorm       → 填产品文档 + 创建 sprint
4. Dev：sprint 拖到新 AI 对话   → 引导写 specs → 评审
5. /spec-canon preview          → 看全貌
```

## License

MIT
