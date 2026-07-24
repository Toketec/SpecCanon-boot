# SpecCanon-boot

> 从 SpecCanon 模板快速创建新项目的一行命令。

```bash
curl -fsSL https://raw.githubusercontent.com/Toketec/SpecCanon-boot/main/init.sh | bash -s new ./my-app "我的项目"
```

## 用途

- **省事**：不用手动 clone → 重命名 → 删 .git → 重新 git init
- **一句话**：`new` 创建新项目，`migrate` 给现有项目嵌入骨架
- **谁都能用**：手动终端、Hermes Agent、任何 AI 终端

## 用法

### new — 创建新项目

```bash
curl -fsSL https://raw.githubusercontent.com/Toketec/SpecCanon-boot/main/init.sh | bash -s new ./photo-app "学校照片SaaS"
```

创建后自动 git init + 初始提交，直接可以 `cd photo-app && code .` 开始开发。

### migrate — 嵌入骨架到现有项目

```bash
curl -fsSL https://raw.githubusercontent.com/Toketec/SpecCanon-boot/main/init.sh | bash -s migrate ../legacy-project "遗留项目"
```

只添加 AGENTS.md、模板目录等骨架，**不修改现有代码**。

### Hermes Agent 中

安装后直接说：

```
spec-canon-boot new ../my-app "项目名"
spec-canon-boot migrate ../legacy-project
```

## 安装（Hermes Agent）

```bash
hermes curator install https://github.com/Toketec/SpecCanon-boot
```

## 项目结构

```
SpecCanon-boot/
├── init.sh        ★ 一行命令入口（curl-pipe-bash 安全）
├── SKILL.md       Hermes skill 描述
├── scripts/
│   └── ssot-init.sh   备用入口（同上逻辑）
└── references/    参考文件
```

## License

MIT
