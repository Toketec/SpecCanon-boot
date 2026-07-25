---
name: spec-rocket
description: "斜杠命令 /spec-canon — 快速建空壳、引导写文档、嵌入骨架、预览全貌。子命令：init, brainstorm, migrate, preview。"
version: 2.1.0
author: Hermes Agent
license: MIT
platforms: [linux, macos]
metadata:
  hermes:
    tags: [spec-canon, project-init, template]
    trigger_phrases: [
      "/spec-canon",
      "spec-canon",
      "初始化",
      "新建项目",
    ]
---

# `/spec-canon` — SpecRocket 项目引导命令

> **本文件是 Hermes Agent 的 skill 安装入口。**
> SpecRocket 本身是 agent 无关的 CLI 工具，任何 AI 编码代理均可驱动。
>
> - **Claude Code / Cursor / Cline / Windsurf / Trae / Workbudy / OpenClaw / Codex** → 读 `CLAUDE.md`
> - **Hermes Agent** → `hermes curator install https://github.com/Toketec/SpecRocket`
> - **纯终端手动** → `curl ... | bash -s init`（见 README）

## 子命令

| 命令 | 用途 |
|:-----|:------|
| `/spec-canon init [项目名]` | 建空壳 + git init |
| `/spec-canon brainstorm` | 引导你填充产品文档 + 创建第一个 sprint |
| `/spec-canon migrate` | 嵌入骨架到现有项目 |
| `/spec-canon preview` | 生成项目可视化预览页 |

---

## `/spec-canon init` — 建空壳

**只做三件事：** 下载模板 → 复制骨架 → git init。

**然后判断：**
- 如果用户需求清晰 → 写 product-overview.md + 第一个 sprint
- 如果需求不清晰 → 告诉用户好了，建议下一步跑 brainstorm

---

## `/spec-canon brainstorm` — 引导填文档

**用途**：建完空壳后，用户不知道写什么，AI 引导他思考。

**AI 执行流程：**

1. **确认已 init** — 检查 `docs/` 目录是否存在，没有就先引导跑 init
2. **提问依次**（每次问一个，等回答后再问下一个）：

   | # | 问题 | 写入哪里 |
   |:--|:-----|:---------|
   | 1 | 这个项目一句话描述是？ | product-overview.md 标题 |
   | 2 | 目标用户是谁？（角色+一句话） | 用户画像表格 |
   | 3 | 用户最核心的场景是什么？ | 核心场景章节 |
   | 4 | 涉及哪些关键术语？ | 术语表 |
   | 5 | 第一个版本最想做什么功能？ | 创建 sprint-NNN |

3. **生成**：
   - 写入 `docs/product-overview.md`（完整产品概览）
   - 从 `_template` 复制创建 `docs/sprints/sprint-001_xxx/`，填写 `SPRINT-features.md`

4. **展示结果**给用户确认
5. **问**：「还要补充什么？直接告诉我改哪里」

**如果用户回答模糊** → 追问「能具体点吗？比如……」
**如果用户说「随便」** → 不猜，告诉他「先写个大概，后面可以随时改」

---

## `/spec-canon migrate` — 嵌入骨架

给现有项目添加 SpecRocket 骨架文件。**不修改现有代码。**

---

## `/spec-canon preview` — 可视化预览

扫描当前项目，在 `docs/preview.html` 生成 dark-theme 预览页。

---

## 关于 Step 2（写 Spec）

**SpecRocket 不做 `/spec-canon plan` 自动写 spec。** 理由：

Step 2 是 Dev 的核心能力。正确的流程是：

```
Dev 把 sprint-001 文档 → 拖到新的 AI 对话中
  （新对话=无记忆、无上下文污染）
  ↓
Dev 给 4 个方向决策：
  ① 归属哪个模块
  ② 是否需要新 ADR
  ③ 跨模块依赖
  ④ 核心函数/API/表名
  ↓
AI 在干净的上下文中写 specs 四文件
  ↓
PM + Dev 评审
```

这样做的好处：
- ✅ 每个 sprint 的 specs 上下文干净，不会被其他 sprint 污染
- ✅ Dev 掌握设计主导权，AI 是执行者
- ✅ Sprint 交付标准化：同一个 sprint 文档 → 同一个 AI 对话 → 同一套 specs

---

## 完整使用路径

```
1. cd ~/projects/photo-app
2. /spec-canon init                  → 建空壳
3. /spec-canon brainstorm            → 填文档 + 创建 sprint（AI 引导）
4. cp -r docs/sprints/_template ...  → 创建更多 sprint（可选）
5. Dev 操作：sprint 拖到新 AI 对话 → 引导写 specs → 评审
6. /spec-canon preview               → 看项目全貌
```

## 一行命令（手动用）

```bash
curl -fsSL https://raw.githubusercontent.com/Toketec/SpecRocket/main/spec-canon | bash -s init
curl ... | bash -s brainstorm
curl ... | bash -s migrate
curl ... | bash -s preview
```
