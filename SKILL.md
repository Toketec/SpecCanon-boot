---
name: spec-canon-boot
description: "从 SpecCanon 模板快速创建新项目 — 一行命令或 AI 一句话搞定：克隆模板→重命名→git init→开发就绪。"
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
      "创建SpecCanon项目",
      "初始化项目",
      "新建项目",
    ]
---

# SpecCanon-boot

> 一句话从 SpecCanon 模板创建新项目。

## 用法

### AI 内（Hermes Agent）

加载本 skill 后直接说：

```
spec-canon-boot new ../photo-app "学校照片SaaS"
spec-canon-boot migrate ../existing-project
```

AI 会自动下载模板并创建项目骨架。

### 人手动用（一行命令，不克隆任何仓库）

```bash
curl -fsSL https://raw.githubusercontent.com/Toketec/SpecCanon-boot/main/init.sh | bash -s new ./my-app "我的项目"
```

### 效果

执行后：
1. ✅ 克隆 SpecCanon 模板
2. ✅ 复制骨架到目标目录
3. ✅ 替换 `{项目名}` 占位符
4. ✅ git init + 初始提交
5. ✅ 显示下一步指引

### 目录结构

```
project/
├── docs/                       # 产品文档（概览、非功能需求、视觉设计）
│   └── sprints/                # 冲刺容器
│       ├── _template/          # 模板（创建新 sprint 时复制）
│       └── sprint-000_initial/ # 初始版本基线
├── apps/                       # 前端应用
├── businesses/                 # 后端服务
├── tools/                      # 工具脚本
├── ADR/                        # 架构决策记录
├── AGENTS.md                   # AI 协作入口
└── ssot-convention.zh.md       # 完整规范手册
```

### 下一步

```bash
cd project
# 写产品概览
# vim docs/product-overview.md
# 创建第一个 sprint
cp -r docs/sprints/_template docs/sprints/sprint-001_name
# 开始开发
```

### 相关链接

| 资源 | 链接 |
|:-----|:------|
| 本仓库 | https://github.com/Toketec/SpecCanon-boot |
| SpecCanon 模板 | https://github.com/Toketec/SpecCanon |
