# SpecRocket

> **AI 时代的规格驱动开发（SSOT）引导工具** — 一键初始化规范项目，任何 AI 编码代理皆可驱动。

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

---

## 🚀 这是什么

**SpecRocket** 是一套**规格驱动开发（Specification-Driven Development）方法论**，专为 AI 时代的人机协作设计。

**SpecRocket** 是入门口 — 一行命令即可创建一个完整遵循 SSOT 规范的骨架项目，你（或任何 AI）可以立即开始协作开发。

---

## 🧠 核心理念：SSOT（Single Source of Truth）

SSOT 是一种 **规格驱动开发（Spec-Driven Development）** 方法论，核心思想是：

> **每个决策都有唯一出处，每个实现都有规格可循。**

---

## 🎯 为什么选择 SpecRocket

**SpecRocket 是一个轻量化的 SDD（规格驱动开发）框架**，以规格驱动思想为主、单一事实源（SSOT）为核心结构。相比 spec-kit、OpenSpec、superpowers、monorepo 等方案，SpecRocket 的差异如下：

| # | 优势 | 说明 |
|:-:|:----|:------|
| 1 | **结构更轻量** | 无 package.json、无构建工具链、无 VS Code 绑定。一个 `curl` 命令即可初始化，只有 3 个根配置 + 3 类模块模板 + 1 个 ADR 模板 + 1 组产品文档模板 |
| 2 | **边界定位清晰，适合企业协作** | 五步法（PM→Dev+AI→评审→AI编码→Dev收尾）明确每个角色做什么/不做什么，PM 不需要懂技术实现，Dev 不需要反复解释需求 |
| 3 | **吸纳敏捷与瀑布优势** | SDD 本质是瀑布思想的阶段门禁（Step 1→2→3→4→5 依次递进），但 `sprints/sprint-NNN/` 结构天然支持多版本迭代。新需求进下一个 sprint，当前 sprint 冻结 |
| 4 | **标准化目录结构，可脱离 AI 交付** | 即使所有 AI 工具消失，`_template/` + 命名约定 + 目录职责表依然是一个可工作的项目管理框架。这是框架最重要的设计——可交付、可复用、可维护 |
| 5 | **标准化产品文档，连贯的单一事实源** | 从 `product-overview.md`（全局锚点）→ `sprints/`（版本设计）→ `ADR/`（架构决策）→ `specs/`（技术规格），信息链路完整可追溯，任何新人/新 AI 打开项目即可理解全局 |
| 6 | **保留 TDD 思想，简化为 check** | 不追求传统 TDD 的 "先写三个测试再写一行代码" 的成本，但保留验收驱动精神：`check.md` 在实现前定义了验收预期，实现后 AI 自检 + QA 签收形成双层验证 |
| 7 | **标准化项目结构框架（核心优势）** | 只有标准化的结构可以脱离 AI 工具进行可交付、可复用、可维护。即使未来方法论被大模型吸纳，这个结构依然适合做团队分工、交付和维护的锚点——而不是面对一堆空白工作空间无从下手 |

---

### 框架对比

| 维度 | SpecRocket | spec-kit | superpowers | OpenSpec | monorepo (nx/turborepo) |
|:----|:----------|:---------|:------------|:--------|:----------------------|
| **定位** | 轻量 SDD 框架 | 规格模板生成器 | 提示词/规则集合 | 开放规格标准 | 构建编排框架 |
| **结构复杂度** | ⭐ 极低 — 3 根配置 + 3×4 模板 | ⭐⭐ — 8+ 文件/模块 + Schema | ⭐⭐ — 多 `.cursorrules` | ⭐ — 裸规格约定 | ⭐⭐⭐⭐⭐ — nx.json/workspace.json/tsconfig 等 |
| **团队角色边界** | ✅ 五步法明确 PM/Dev/AI 职责 | ❌ 无角色定义 | ❌ 无角色定义 | ❌ 无角色定义 | ❌ 仅 Dev 视角 |
| **工具绑定** | 纯文件驱动，任何 AI Agent + Git 即可 | CLI-dependent | VS Code / Cursor 独占 | 无绑定 | nx/turborepo CLI |
| **AI 独立交付** | ✅ `_template/` + 命名约定，脱 AI 可交付 | ❌ 依赖 CLI 生成 | ❌ 依赖 IDE 插件 | ✅ 纯约定 | ❌ 依赖构建工具 |
| **迭代支持** | ✅ sprints/sprint-NNN/ 多版本容器 | ❌ 单次生成 | ❌ 无迭代机制 | ❌ 单层规格 | ❌ 不相关 |
| **产品文档** | ✅ 产品概览 + 场景 + 流程 + 原型 + 线框图 | ❌ 仅技术规格 | ❌ 仅提示词 | ❌ 仅规格 | ❌ 不相关 |
| **ADR/架构** | ✅ 内置 ADR 模板 + 生命周期 | ❌ 无 | ❌ 无 | ❌ 无 | ❌ 不相关 |
| **测试策略** | ✅ 简化 TDD → check.md（AI 自检 + QA 签收） | ❌ 无 | ❌ 无 | ❌ 无 | ❌ 不相关 |
| **跨模块契约** | ✅ Context Contract（≤15 行） | ❌ 无 | ❌ 无 | ⭐ 有接口定义 | ❌ 不相关 |
| **状态追踪** | ✅ sprint/spec/ADR 全生命周期 | ❌ 无 | ❌ 无 | ❌ 无 | ❌ 不相关 |
| **学习成本** | ⭐ 30 分钟通读 ssot-convention | ⭐⭐ 需学 Schema 语法 | ⭐ 低（规则即用） | ⭐ 低 | ⭐⭐⭐⭐ 需学 nx 概念 |
| **迁移路径** | ✅ Retrospec 4 阶段渐进式 | ❌ 只能新项目 | ✅ 可嵌入现有项目 | ✅ 纯约定 | ❌ 需重构项目结构 |
| **适用范围** | 企业级项目、Hackathon、个人项目 | 个人项目 | AI 辅助个人 | 开放协作 | 大型前端 monorepo |

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
| **SpecRocket 框架模板** | `template/`（submodule） | SSOT 完整骨架文件 + 规范手册 + 培训 PPT，**浏览/初始化参考** |

```
SpecRocket/
├── spec-canon               ← CLI 脚本（curl | bash）
├── CLAUDE.md                ← Agent 指令（自动识别）
├── template/ (submodule)    ← SpecRocket 框架模板
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
curl -fsSL https://raw.githubusercontent.com/Toketec/SpecRocket/main/spec-canon | bash -s init "项目名"

# 引导填写产品文档 + 创建第一个 sprint
curl -fsSL https://raw.githubusercontent.com/Toketec/SpecRocket/main/spec-canon | bash -s brainstorm

# 给现有项目嵌入 SSOT 骨架（不修改代码）
curl -fsSL https://raw.githubusercontent.com/Toketec/SpecRocket/main/spec-canon | bash -s migrate

# 生成 dark-theme 项目预览页（浏览器打开 docs/preview.html）
curl -fsSL https://raw.githubusercontent.com/Toketec/SpecRocket/main/spec-canon | bash -s preview
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

SpecRocket 设计为 **任何 AI 编码代理均可驱动**。

| Agent | 识别方式 |
|:------|:---------|
| Claude Code | `CLAUDE.md` 自动加载 |
| Cursor | `.cursorrules` / `CLAUDE.md` |
| Windsurf | `.windsurfrules` |
| Cline / Roo Code | `CLAUDE.md` 兼容 |
| Trae | `CLAUDE.md` 兼容 |
| OpenClaw | `CLAUDE.md` 兼容 |
| Codex CLI | `CLAUDE.md` 兼容 |
| Aider | `CONVENTIONS.md` |
| Cursor | `CLAUDE.md` 自动加载 |

---

## 📚 学习资源

| 资源 | 位置 | 说明 |
|:----|:----|:-----|
| SSOT 完整规范手册 | `ssot-convention.zh.md` | 580 行全流程规范（建议新成员阅读） |
| SSOT 培训 PPT | `SSOT-开发方法论-培训.pptx` | 团队培训用演示文稿 |
| AI 协作规范 | `template/AGENTS.md` | AI 在五步流程中的角色和边界 |
| 克隆后用 | `git clone --recursive https://github.com/Toketec/SpecRocket.git` | 包含 template submodule |

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

> **SpecRocket 框架模板**托管在独立的 [Toketec/SpecRocket-template](https://github.com/Toketec/SpecRocket-template) 仓库，作为本仓库的 submodule 引入。
