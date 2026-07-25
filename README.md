# SpecCanon-boot

> `/spec-canon` — 一键初始化 SSOT 规范项目。任何 AI 编码代理皆可驱动。

---

## 一行命令（最通用）

```bash
# 在当前目录初始化空壳项目 + git init
curl -fsSL https://raw.githubusercontent.com/Toketec/SpecCanon-boot/main/spec-canon | bash -s init "项目名"

# 引导填写产品文档 + 创建第一个 sprint
curl -fsSL https://raw.githubusercontent.com/Toketec/SpecCanon-boot/main/spec-canon | bash -s brainstorm

# 给现有项目嵌入 SpecCanon 骨架（不修改代码）
curl -fsSL https://raw.githubusercontent.com/Toketec/SpecCanon-boot/main/spec-canon | bash -s migrate

# 生成 dark-theme 项目预览页（浏览器打开 docs/preview.html）
curl -fsSL https://raw.githubusercontent.com/Toketec/SpecCanon-boot/main/spec-canon | bash -s preview
```

> 💡 **一行命令 = 无需克隆仓库**，`curl | bash` 在任何终端都可用。

---

## 子命令

| 命令 | 用途 |
|:----|:------|
| `init [项目名]` | 建空壳 + git init（核心）|
| `brainstorm` | 引导填充产品文档 + 创建 sprint |
| `migrate` | 嵌入骨架到现有项目 |
| `preview` | 生成项目可视化预览页 `docs/preview.html` |

---

## 克隆后用

```bash
git clone https://github.com/Toketec/SpecCanon-boot.git
cd SpecCanon-boot

./spec-canon init "学校照片SaaS"
./spec-canon brainstorm
./spec-canon preview
```

---

## Agent 驱动

SpecCanon-boot 设计为 **任何 AI 编码代理均可驱动**。项目根目录的 `CLAUDE.md` 自动告诉 agent 如何理解和执行子命令。

| Agent | 支持方式 |
|:------|:---------|
| **Claude Code** | `CLAUDE.md` 自动加载 |
| **Cursor** | `.cursorrules` / `CLAUDE.md` |
| **Windsurf** | `.windsurfrules` |
| **Cline / Roo Code** | `CLAUDE.md` 兼容 |
| **Trae** | `CLAUDE.md` 兼容 |
| **Workbudy** | `CLAUDE.md` 兼容 |
| **OpenClaw** | `CLAUDE.md` 兼容 |
| **Codex CLI** | `CLAUDE.md` 兼容 |
| **Aider** | `CONVENTIONS.md` |
| **Hermes Agent** | `hermes curator install https://github.com/Toketec/SpecCanon-boot` |

---

## 完整使用路径

```
1. cd ~/projects/photo-app
2. /spec-canon init                → 建空壳
3. /spec-canon brainstorm          → 填产品文档 + 创建 sprint（AI 引导）
4. Dev：sprint 拖到新 AI 对话      → 引导写 specs → 评审
5. /spec-canon preview             → 看项目全貌
```

---

## SpecCanon 五步开发流程

```
Step 1 │ PM 独作: docs/ + sprints/（产品文档 + 原型 + 冲刺）
Step 2 │ Dev+AI 独作: ADR/ + 模块/specs/（架构 + 规格四文件）
Step 3 │ PM+Dev 评审 spec 是否能解决业务需求
Step 4 │ AI 按 spec 编码（读 requirements → plan → 实现 → tasks → 自检）
Step 5 │ Dev 收尾（修 bug → 集成 → QA 跑 check.md → 签收）
```

详见 SpecCanon 模板项目中的 `AGENTS.md` 和 `ssot-convention.zh.md`。

---

## License

MIT — 属于 [Toketec](https://github.com/Toketec) 组织。
