# SpecCanon-boot

> **AI 时代的规格驱动开发（SSOT）引导工具** — 一键初始化规范项目，任何 AI 编码代理皆可驱动。

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

---

## 🚀 这是什么

**SpecCanon** 是一套**规格驱动开发（Specification-Driven Development）方法论**，专为 AI 时代的人机协作设计。

**SpecCanon-boot** 是入门口 — 一行命令即可创建一个完整遵循 SSOT 规范的骨架项目，你（或任何 AI）可以立即开始协作开发。

---

## 🧠 核心理念：SSOT（Single Source of Truth）

SSOT 是一种 **规格驱动开发（Spec-Driven Development）** 方法论，核心思想是：

> **每个决策都有唯一出处，每个实现都有规格可循。**

### 与传统开发的差别

| # | 维度 | 传统开发 | SSOT |
|:-:|:----|:--------|:-----|
| 1 | **输入** | 口头需求 / PRD 文档 | `docs/sprints/` 完整产品设计 |
| 2 | **决策** | 群聊/会议口头决定 | `ADR/` 架构决策记录，永久可查 |
| 3 | **编码** | Dev 手写 → 凭记忆改 | AI 按 `specs/` 四文件执行 |
| 4 | **评审** | 代码 review | 先评 spec → 再验代码 |
| 5 | **AI 协作** | 一问一答，上下文反复丢失 | 五步流程，AI 有完整上下文 |
| 6 | **知识沉淀** | 代码里翻 | `docs/` + `ADR/` + `specs/` 明文化 |

### 五步开发流程

```
┌─────────────────────────────────────────────────────────────────┐
│ Step 1 │ PM 独作 — 产品设计阶段                                │
│         │ 产出: docs/ + docs/sprints/ + prototypes/            │
│         │ AI 角色: 协助润色、画图、生成原型模板                  │
├─────────────────────────────────────────────────────────────────┤
│ Step 2 │ Dev+AI 独作 — 架构设计与规格编写                      │
│         │ Dev 给 4 个方向决策(10min) → AI 写完整四文件          │
│         │ 产出: ADR/ + {apps|biz|tools}/*/specs/               │
├─────────────────────────────────────────────────────────────────┤
│ Step 3 │ PM + Dev 共同 — 方案评审                              │
│         │ PM 审: "方案能否解决业务需求?"                        │
│         │ TL 审: "架构合理、边界清晰?"                          │
│         │ → 通过 或 打回 Step 2                                │
├─────────────────────────────────────────────────────────────────┤
│ Step 4 │ AI 按 spec 执行 — 编码                               │
│         │ 读 requirements.md + plan.md → 实现 → tasks.md → 自检 │
├─────────────────────────────────────────────────────────────────┤
│ Step 5 │ Dev 收尾 — 验收                                      │
│         │ 修小bug → 集成 → QA 跑 check.md → 签收              │
└─────────────────────────────────────────────────────────────────┘
```

**关键设计：** 5 个步骤中 PM 和 Dev 只做 2 件真人决策的事（Step 1 产品设计、Step 3 评审），其余交给 AI。**AI 按规格编码，不跳步骤、不改方案**。

---

## 📦 仓库结构

本仓库包含两个组件：

| 组件 | 位置 | 用途 |
|:----|:----|:-----|
| **`spec-canon` CLI** | 根目录 | 一行命令初始化/引导/预览，**宣传入口** |
| **SpecCanon 框架模板** | `template/`（submodule） | SSOT 完整骨架文件 + 规范手册 + 培训 PPT，**浏览/初始化参考** |

```
SpecCanon-boot/
├── spec-canon               ← CLI 脚本（curl | bash）
├── CLAUDE.md                ← Agent 指令（自动识别）
├── template/ (submodule)    ← SpecCanon 框架模板
│   ├── ssot-convention.zh.md    ← 完整规范手册（580行）
│   ├── AGENTS.md                ← AI 协作入口
│   ├── SSOT-开发方法论-培训.pptx ← 培训 PPT
│   ├── docs/                    ← 产品文档模板
│   ├── ADR/                     ← 架构决策记录模板
│   ├── apps/ / businesses/ / tools/  ← 模块模板（含 specs/）
│   └── ...
└── README.md
```

> 💡 需要查看框架细节？见 [`template/`](template/) 子模块。

---

## ⚡ 快速开始：一行命令

```bash
# 初始化新项目（任意目录执行）
curl -fsSL https://raw.githubusercontent.com/Toketec/SpecCanon-boot/main/spec-canon | bash -s init "项目名"

# 引导填写产品文档 + 创建第一个 sprint
curl -fsSL https://raw.githubusercontent.com/Toketec/SpecCanon-boot/main/spec-canon | bash -s brainstorm

# 给现有项目嵌入 SSOT 骨架（不修改代码）
curl -fsSL https://raw.githubusercontent.com/Toketec/SpecCanon-boot/main/spec-canon | bash -s migrate

# 生成 dark-theme 项目预览页（浏览器打开 docs/preview.html）
curl -fsSL https://raw.githubusercontent.com/Toketec/SpecCanon-boot/main/spec-canon | bash -s preview
```

> 🔥 **无需克隆、无需安装**，任何终端可用。

### 子命令一览

| 命令 | 用途 | 适用场景 |
|:----|:-----|:---------|
| `init` | 创建空壳项目 + git init | 新项目启动 |
| `brainstorm` | 引导式填写产品文档 + 创建 sprint | 需求不清晰时 |
| `migrate` | 给现有项目嵌入 SSOT 骨架 | 存量项目迁移 |
| `preview` | 生成项目全貌可视化页 | 项目总览 |

### 完整开发路径

```
1. cd ~/projects/photo-app
2. /spec-canon init                → 建空壳
3. /spec-canon brainstorm          → 填产品文档 + 创建 sprint
4. Dev：sprint 拖到新 AI 对话      → 引导写 specs → 评审
5. /spec-canon preview             → 看项目全貌
```

---

## 🤖 Agent 兼容性

SpecCanon-boot 设计为 **任何 AI 编码代理均可驱动**。

| Agent | 识别方式 |
|:------|:---------|
| Claude Code | `CLAUDE.md` 自动加载 |
| Cursor | `.cursorrules` / `CLAUDE.md` |
| Windsurf | `.windsurfrules` |
| Cline / Roo Code | `CLAUDE.md` 兼容 |
| Trae | `CLAUDE.md` 兼容 |
| Workbudy | `CLAUDE.md` 兼容 |
| OpenClaw | `CLAUDE.md` 兼容 |
| Codex CLI | `CLAUDE.md` 兼容 |
| Aider | `CONVENTIONS.md` |
| Hermes Agent | `hermes curator install https://github.com/Toketec/SpecCanon-boot` |
| Cursor | `CLAUDE.md` 自动加载 |

---

## 📚 学习资源

| 资源 | 位置 | 说明 |
|:----|:----|:-----|
| SSOT 完整规范手册 | `template/ssot-convention.zh.md` | 580 行全流程规范（建议新成员阅读） |
| SSOT 培训 PPT | `template/SSOT-开发方法论-培训.pptx` | 团队培训用演示文稿 |
| AI 协作规范 | `template/AGENTS.md` | AI 在五步流程中的角色和边界 |
| 克隆后用 | `git clone --recursive https://github.com/Toketec/SpecCanon-boot.git` | 包含 template submodule |

---

## 🏗️ 适用场景

| 场景 | 推荐路径 |
|:----|:---------|
| **新项目启动** | `init` → `brainstorm` → 五步流程 |
| **现有人类项目引入 AI 协作** | `migrate` → 写 ADR + Retrospec |
| **Hackathon 快速验证** | `init` → 跳过 Step 1 → 直接 Step 4 AI 编码 |
| **团队培训** | 先跑 init 看骨架 → 读 ssot-convention → 跑 PPT 培训 |
| **AI-only 项目** | `init` → 全部步骤由 AI 完成，Dev 只做 Step 3 评审 |

---

## 📄 License

MIT — 属于 [Toketec](https://github.com/Toketec) 组织。

---

> **SpecCanon 框架模板**托管在独立的 [Toketec/SpecCanon](https://github.com/Toketec/SpecCanon) 仓库，作为本仓库的 submodule 引入。
