---
name: spec-rocket
description: "斜杠命令 /spec-rocket — 规格驱动开发（SDD）框架。子命令：init, brainstorm, migrate, preview。"
version: 2.1.0
license: MIT
---

# `/spec-rocket` — SpecRocket 项目引导命令

> SpecRocket 的 AI 协作指南。任何 AI 编码代理（Claude Code、Cursor、Cline、Windsurf、Codex、Hermes Agent 等）均可按本文档指引执行 `/spec-rocket` 命令。
>
> 安装方式：克隆本仓库 → AI 读取 `SKILL.md`（或将本文档内容注入为系统提示词）。

## 仓库结构

```
SpecRocket/                      ← 本仓库
├── SKILL.md                    ← 标准 skill 文件（AI 斜杠命令）
├── init.sh                     ← 手动 init 脚本（无 AI 时用）
├── template/ (submodule)       ← 项目模板框架
│   ├── ssot-convention.zh.md   ← 完整 SSOT 规范手册
│   ├── AGENTS.md               ← AI 协作规则
│   ├── SSOT-开发方法论-培训.pptx ← 培训 PPT
│   ├── docs/                   ← 产品文档模板
│   ├── ADR/                    ← 架构决策模板
│   ├── apps/businesses/tools/  ← 模块模板
│   └── ...
├── README.md                   ← 项目介绍
├── LICENSE                     ← MIT License
```

## 斜杠命令

全部命令在 AI 对话中以 `/spec-rocket` 开头：

| 命令 | 用途 |
|:----|:------|
| `init [项目名]` | 从 template/ 子模块复制骨架到新项目 |
| `brainstorm` | 引导用户描述产品 → 自动生成产品文档 + 创建 sprint |
| `migrate` | 给现有项目嵌入骨架文件 |
| `preview` | 扫描项目 → 生成 dark-theme 可视化预览页 |

---

## `/spec-rocket init` — 建新项目

**做什么：** 从 `template/` submodule 复制 SpecRocket 骨架到新项目，初始化 Git。

**手动执行（无 AI 时）：**
```bash
./init.sh 项目名
```

**AI 斜杠命令执行时：**
1. 检查当前是否为空目录（或用户指定了新项目路径）
2. 从本仓库的 `template/` 子模块复制完整骨架到目标目录
3. 执行 `git init`
4. 判断：
   - 用户需求清晰 → 继续写 `docs/product-overview.md` + 第一个 sprint
   - 需求不清晰 → 告诉用户完成，建议下一步跑 `/spec-rocket brainstorm`

---

## `/spec-rocket brainstorm` — 引导填文档

**用途：** 用户已经有项目（刚 init 或现有项目），不清楚怎么写文档。AI 用 5 个问题引导。

**执行流程：**
1. 确认 `docs/` 存在，没有就先跑 init
2. 依次提问（每次一个，等回答再问下一个）：

   | # | 问题 | 写入哪里 |
   |:--|:-----|:---------|
   | 1 | 一句话描述这个产品？ | `product-overview.md` 标题 |
   | 2 | 目标用户是谁？（角色+一句话） | 用户画像表格 |
   | 3 | 最核心的场景是什么？ | 核心场景章节 |
   | 4 | 涉及哪些关键术语？ | 术语表 |
   | 5 | 第一个版本最想做什么功能？ | 创建 sprint-NNN |

3. 生成 `docs/product-overview.md` + 从 `_template` 复制 sprint-001
4. 展示结果给用户确认
5. 问："还要补充什么？直接告诉我改哪里"

---

## `/spec-rocket migrate` — 嵌入骨架

**用途：** 给已有项目（非 SpecRocket）添加骨架文件。

**执行规则：** 只添加不存在的文件，不修改现有代码。

添加清单：
- `AGENTS.md`、`ssot-convention.zh.md`、`.gitignore`
- 目录模板：`docs/sprints/_template`、`apps/_template`、`businesses/_template`、`tools/_template`、`ADR/_template`

---

## `/spec-rocket preview` — 可视化预览

**用途：** 扫描当前项目，生成 `docs/preview.html`（dark-theme 预览页）。

页面包含：产品定位、用户画像、核心场景、模块清单、Sprint 路线图、ADR 决策树、技术栈、项目统计。

---

## 关于 Step 2（写 Spec）

SpecRocket **不做** `/spec-rocket plan` 自动写 spec。理由：

```
Dev 把 sprint-001 文档 → 拖到新的 AI 对话中（干净上下文）
  ↓
Dev 给 4 个方向：
  ① 归属哪个模块
  ② 是否需要新 ADR
  ③ 跨模块依赖
  ④ 核心函数/API/表名
  ↓
AI 在干净上下文中写 specs 四文件
  ↓
PM + Dev 评审
```

## 完整使用路径

```chat
# 场景 A：新项目（空目录）
你：帮我进入一个新项目目录
AI：已进入 ~/projects/my-app（空目录）
→ 你：/spec-rocket init "我的项目"
→ AI：从 template/ 复制骨架 → git init
→ 你：/spec-rocket brainstorm
→ AI：5 问引导 → 生成产品文档 + sprint

# 场景 B：已有老项目
你：帮我进入 ~/projects/legacy-app
→ 你：/spec-rocket preview
→ AI：分析现有项目 → 生成全貌预览
→ 你：/spec-rocket migrate
→ AI：嵌入骨架（不碰代码）
→ 或：/spec-rocket brainstorm
→ AI：引导描述产品 → 生成文档
```
