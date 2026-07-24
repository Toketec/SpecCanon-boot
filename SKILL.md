---
name: spec-canon-boot
description: "SpecCanon 项目引导 — 基于 SSOT 规格驱动方法论的通用项目初始化工具。一行命令创建，自动适配 Hermes/Claude Code/Cursor/Codex/Trae 等所有 AI 环境。"
version: 2.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos]
metadata:
  hermes:
    tags: [ssot, bootstrap, template, project-init, migration, multi-ai]
    trigger_phrases: [
      "spec-canon-boot",
      "SpecCanon boot",
      "SpecCanon new",
      "SpecCanon migrate",
      "spec canon boot",
      "创建SpecCanon项目",
      "迁移到ssot",
      "ssot引导",
      "新建项目",
    ]
---

# SpecCanon-boot — 通用项目引导 Skill

> **通用 Skill**：不仅是 Hermes skill，也是 Claude Code / Cursor / Codex CLI / Trae / OpenClaw / WorkBuddy 等**所有 AI 环境**的初始化入口。
> 一份方法论，自动适配各 AI 的约定文件名。

---

## 使用方式

### 🔵 手动（一行命令，不克隆任何东西）

```bash
curl -fsSL https://raw.githubusercontent.com/Toketec/SpecCanon-boot/main/init.sh | bash -s new ./my-app "我的项目"
```

自动检测当前运行的 AI 环境，生成对应约定文件。

### 🔵 手动 + 指定 AI

```bash
curl ... | bash -s new ./my-app "项目名" --ai cursor
curl ... | bash -s migrate ./legacy-project --ai claude-code
```

### 🟣 Hermes Agent 内使用

```bash
# 加载本 skill 后直接调用
spec-canon-boot new ../photo-app "学校照片SaaS"
spec-canon-boot migrate ../legacy-project
spec-canon-boot new ./app --ai codex
```

### 🟢 其他 AI 内使用

在任何 AI 终端中，直接运行：
```bash
# AI 会自动检测当前环境
/init.sh new ./my-app "我的项目"
```
或让 AI 运行 `curl | bash` 一行命令。

---

## 支持的 AI 环境

| AI | 约定文件 | 说明 |
|:---|:---------|:-----|
| **Hermes Agent** | `AGENTS.md` | 原生支持 |
| **Claude Code** | `CLAUDE.md` | Anthropic CLI |
| **Cursor IDE** | `.cursorrules` | Cursor 项目级规则 |
| **Codex CLI** | `CODEX.md` | OpenAI 终端 |
| **Trae** | `.trae/rules/ssot.md` | 字节跳动 AI IDE |
| **OpenClaw** | `OPENCLAW.md` | |
| **WorkBuddy** | `WORKBUDDY.md` | |

> 不指定 `--ai` 时自动检测（环境变量 → 父进程名 → 全生成）。

---

## 核心流程

所有 AI 共享同一套方法论（`conventions/ssot-skill.md`）：

```
Step 1 │ PM 独作: docs/ + sprints/ (产品设计)
Step 2 │ Dev+AI 独作: ADR/ + 模块/specs/ (架构+规格)
Step 3 │ PM+Dev 碰面评审
Step 4 │ AI 按 spec 编码 → 自检 → 展示 → 等确认
Step 5 │ Dev 收尾 → QA
```

详见项目内的 `AGENTS.md` / `CLAUDE.md` / 等（以当前 AI 对应的文件名）。

---

## Hermes Skill API

| 命令 | 说明 |
|:----|:------|
| `spec-canon-boot new <路径> [名称] [--ai <AI>]` | 创建新项目 |
| `spec-canon-boot migrate <路径> [名称] [--ai <AI>]` | 迁移现有项目 |
| `spec-canon-boot list-ai` | 列出所有支持的 AI 环境 |

`spec-canon-boot` 是 `init.sh` 的别名，行为完全一致。

---

## 目录结构

```
project/
├── AGENTS.md                    # 通用 AI 方法论（本文档）
├── CLAUDE.md                    # Claude Code 版（自动生成）
├── .cursorrules                 # Cursor 版
├── ...                          # 其他 AI 约定文件（按需）
├── docs/
│   ├── product-overview.md
│   ├── sprints/_template/
│   └── sprints/sprint-000_initial/
├── apps/
├── businesses/
├── tools/
├── ADR/
├── ssot-convention.zh.md
└── README.md
```

---

## AI 手动初始化（不通过本 skill 时）

如果某个 AI 终端加载本 skill 失败，直接把以下内容写入项目根目录的对应文件：

| 文件 | 内容来源 |
|:----|:---------|
| `AGENTS.md` | `conventions/ssot-skill.md`（通用方法论） |
| `CLAUDE.md` | 同上 + 文件头注释 |
| `.cursorrules` | 同上 + 文件头注释 |

<<<<<<< HEAD
# ✅ 正确（如果 cwd 是 /home/user/projects）
bash ssot-init.sh new ./my-app "我的应用"

# ❌ 避免模糊路径
```

### 2. 迁移时检查文件冲突

```bash
# 迁移前快速检查目标目录
ls -la /path/to/existing-project/AGENTS.md 2>/dev/null && echo "⚠️ AGENTS.md 已存在" || echo "✅ 可创建 AGENTS.md"
```

### 3. 迁移后不要重构成品结构

如果现有项目有自己的目录结构（如 `src/`, `lib/`, `server/`），**不要**强制改成 `apps/`/`businesses/` 结构。SSOT 的 `apps/`/`businesses/` 是给**新模块**用的。现有代码保持原位，通过 Retrospec 记录边界即可。

### 4. GitHub 网络问题

如果从 GitHub 拉取模板失败，可以：
```bash
# 检查是否有本地方法论仓库
ls "$HOME/SpecCanon/scripts/bootstrap-project.sh" 2>/dev/null && echo "本地模板可用"
# 如果本地有，直接用本地模板
```

---

## 验证

创建/迁移完成后，验证骨架就绪：

```bash
cd /path/to/project

# 核心文件存在
ls AGENTS.md ssot-convention.zh.md
ls docs/sprints/_template/SPRINT-features.md
ls docs/sprints/sprint-000_initial/SPRINT-features.md
ls apps/_template/specs/requirements.md
ls businesses/_template/specs/requirements.md
ls ADR/_template/ADR.md

# 项目名已替换（如果是新建项目）
grep "{项目名}" AGENTS.md 2>/dev/null && echo "⚠️ 还有未替换的占位符" || echo "✅ 占位符已替换"
```
=======
所有 AI 读同一份方法论，只是文件名不同。
>>>>>>> 9bc03ef (feat: v2.0 — 通用多 AI 初始化系统)

---

## 相关资源

| 资源 | 链接 |
|:----|:------|
| 本仓库 | https://github.com/Toketec/SpecCanon-boot |
| 一行命令入口 | `init.sh`（项目根目录） |
| 方法论模板仓库 | https://github.com/Toketec/SpecCanon |
| 通用 AI 方法论 | `conventions/ssot-skill.md` |
| AI 映射表 | `ai-bridge/manifest.json` |
| 完整规范 | `ssot-convention.zh.md`（在项目中） |
