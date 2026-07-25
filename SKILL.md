---
name: spec-canon-boot
description: "在当前目录快速创建 SpecCanon 项目骨架 + git init。如果需求清晰，进一步编写产品文档和 sprint。"
version: 2.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos]
metadata:
  hermes:
    tags: [spec-canon, bootstrap, project-init, template]
    trigger_phrases: [
      "spec-canon-boot",
      "SpecCanon new",
      "SpecCanon migrate",
      "初始化项目",
      "新建项目",
      "使用SpecCanon",
    ]
---

# SpecCanon-boot

> 在当前目录快速创建 SpecCanon 模板项目。

## 用户怎么说

| 用户说 | 我做什么 |
|:-------|:---------|
| `spec-canon-boot new` | 在当前目录创建骨架 + git init |
| `spec-canon-boot new "照片SaaS"` | 创建骨架，项目名叫"照片SaaS" |
| `spec-canon-boot new ../photo-app` | 在指定目录创建 |
| `spec-canon-boot migrate` | 在当前项目嵌入 SpecCanon 骨架（不改代码） |

## AI 执行流程

### Step 1: 创建骨架（必须做）

```bash
# 方法A：用当前 Hermes skill（推荐）
# 直接调用本 skill 的逻辑来完成

# 方法B：运行 init.sh
curl -fsSL https://raw.githubusercontent.com/Toketec/SpecCanon-boot/main/init.sh | bash -s new
```

这一步始终执行，不论需求是否清晰。

### Step 2: 判断需求清晰度

骨架就绪后，看用户对**这个项目**的描述：

- **需求清晰**（用户说了项目做什么、目标用户、核心功能）→ 继续写：
  - `docs/product-overview.md` — 产品概览（用户画像、术语表、一句话定位）
  - `docs/sprints/sprint-001_name/` — 复制模板并填写 SPRINT-features.md
  - 告诉用户：「骨架已创建，产品文档初稿也写好了，你看看对不对」

- **需求不清晰**（用户只说「帮我初始化项目」，没提具体做什么）→ 停：
  - 告诉用户：「骨架已建好，下一步可以写产品文档。你想做什么类型的项目？」
  - 列出 `docs/product-overview.md` 需要填的内容

### 目录结构（创建后）

```
项目目录/
├── docs/product-overview.md   ← 产品概览（AI 可帮你写）
├── docs/sprints/_template/    ← 冲刺模板（创建新 sprint 时复制）
├── apps/                      ← 前端应用
├── businesses/                ← 后端服务
├── tools/                     ← 工具脚本
├── ADR/                       ← 架构决策记录
├── AGENTS.md                  ← AI 协作入口
└── ssot-convention.zh.md      ← 完整规范
```

### 相关链接

- 模板仓库: https://github.com/Toketec/SpecCanon
- 本工具: https://github.com/Toketec/SpecCanon-boot
