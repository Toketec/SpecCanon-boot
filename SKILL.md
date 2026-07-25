---
name: spec-canon-boot
description: "斜杠命令 /spec-canon — 快速建空壳、嵌入骨架、预览项目全貌。子命令：init, migrate, preview。"
version: 2.0.0
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

# `/spec-canon` — SpecCanon 项目引导命令

## 子命令

| 命令 | 用途 |
|:-----|:------|
| `/spec-canon init [项目名]` | 在当前目录建空壳 + git init（核心） |
| `/spec-canon migrate` | 在当前项目嵌入 SpecCanon 骨架 |
| `/spec-canon preview` | 生成项目可视化预览页 |

## 执行流程

### `/spec-canon init [项目名]`

**核心功能。只做三件事：**
1. 下载 SpecCanon 模板
2. 复制骨架到当前目录（不写业务内容）
3. git init + 初始提交

**然后判断用户需求清晰度：**
- **需求清晰**（用户说了要做什么）→ 继续写 `docs/product-overview.md` 和第一个 sprint
- **需求不清晰** → 告诉用户：「空壳已就绪，可以编辑 product-overview.md 开始」

### `/spec-canon migrate`

在当前项目嵌入 SpecCanon 骨架文件（AGENTS.md、模板目录），**不修改现有代码**。

### `/spec-canon preview`

扫描当前项目，在 `docs/preview.html` 生成可视化预览页：

```
🎯 产品预览 — 定位、用户画像、场景
🗺️ 业务地图 — 模块清单、Sprint 路线
🏗️ 技术架构 — ADR 决策树、技术栈
```

## 手动一行命令

```bash
# 建空壳
curl -fsSL https://raw.githubusercontent.com/Toketec/SpecCanon-boot/main/spec-canon | bash -s init

# 指定项目名
curl ... | bash -s init "学校照片SaaS"

# 嵌入骨架
curl ... | bash -s migrate

# 可视化预览
curl ... | bash -s preview
```

## 安装

```bash
hermes curator install https://github.com/Toketec/SpecCanon-boot
```
