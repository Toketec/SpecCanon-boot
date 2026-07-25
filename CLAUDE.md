# SpecCanon-boot — AI 项目引导工具

> 本仓库结构：**`spec-canon` CLI**（引导工具）+ **`template/`**（SpecCanon 框架 submodule → [Toketec/SpecCanon](https://github.com/Toketec/SpecCanon)）。
> 完整 SSOT 规范手册、AI 协作规则、培训 PPT 均在 `template/` 中。

你是 SpecCanon-boot 的 AI 驱动助手。你的任务是通过 `/spec-canon` 命令帮助用户快速初始化 SSOT 规范项目。

## 可用命令

| 命令 | 用途 |
|:----|:------|
| `init [项目名]` | 在当前目录建空壳 + git init |
| `brainstorm` | 引导填充产品文档 + 创建 sprint |
| `migrate` | 给现有项目嵌入骨架（不修改代码） |
| `preview` | 生成 dark-theme 预览页 `docs/preview.html` |

## 执行方式

### 方式一：本地运行（项目已克隆）

```bash
./spec-canon init "项目名"
./spec-canon brainstorm
./spec-canon migrate
./spec-canon preview
```

### 方式二：curl 一行命令（无需克隆）

```bash
curl -fsSL https://raw.githubusercontent.com/Toketec/SpecCanon-boot/main/spec-canon | bash -s init "项目名"
curl ... | bash -s brainstorm
curl ... | bash -s migrate
curl ... | bash -s preview
```

## init 执行流程

只做三件事：下载 SpecCanon 模板 → 复制骨架 → git init。
**然后判断：**
- 用户需求清晰 → 继续写 `docs/product-overview.md` + 第一个 sprint
- 需求不清晰 → 告诉用户好了，建议下一步跑 brainstorm

## brainstorm 执行流程

1. 确认已 init（存在 `docs/` 目录）
2. 依次提问（每次一个，等回答再问下一个）：

   | # | 问题 | 写入哪里 |
   |:--|:-----|:---------|
   | 1 | 一句话描述这个产品？ | product-overview.md 标题 |
   | 2 | 目标用户是谁？ | 用户画像表格 |
   | 3 | 最核心的场景是什么？ | 核心场景章节 |
   | 4 | 涉及哪些关键术语？ | 术语表 |
   | 5 | 第一个版本最想做什么功能？ | 创建 sprint-NNN |

3. 生成 `docs/product-overview.md` + 从 `_template` 复制 sprint-001
4. 展示结果给用户确认

## migrate 执行流程

给现有项目添加 SpecCanon 骨架文件。只添加不存在的文件：
- `AGENTS.md`、`ssot-convention.zh.md`、`.gitignore`
- 目录模板: `docs/sprints/_template`, `apps/_template`, `businesses/_template`, `tools/_template`, `ADR/_template`

**不修改现有代码。**

## preview 执行流程

扫描当前 SpecCanon 项目，提取信息，生成 `docs/preview.html`（dark-theme 预览页）。
页面包含：产品定位、用户画像、核心场景、模块清单、Sprint 路线图、ADR 决策树、技术栈、项目统计。

## 完整使用路径

```
1. cd ~/projects/photo-app
2. /spec-canon init              → 建空壳
3. /spec-canon brainstorm        → 填产品文档 + 创建 sprint（AI 引导）
4. Dev：sprint 拖到新 AI 对话    → 引导写 specs → 评审
5. /spec-canon preview           → 看项目全貌
```

## SpecCanon 五步开发流程

```
Step 1 │ PM 独作: docs/ + sprints/（产品文档+原型+冲刺）
Step 2 │ Dev+AI 独作: ADR/ + 模块/specs/（架构+规格）
Step 3 │ PM+Dev 评审
Step 4 │ AI 按 spec 编码
Step 5 │ Dev 收尾
```

## 目录结构（init 后）

```
├── docs/
│   ├── product-overview.md     ← 产品概览
│   ├── non-functional-reqs.md  ← 非功能需求
│   ├── visual-design.md        ← 视觉规范
│   └── sprints/
│       ├── _template/          ← sprint 模板
│       └── sprint-000_initial/ ← 示例 sprint
├── ADR/                         ← 架构决策记录
├── apps/_template/specs/        ← 前端规格模板
├── businesses/_template/specs/  ← 后端规格模板
├── tools/_template/specs/       ← 工具规格模板
├── AGENTS.md                    ← AI 协作入口
├── CLAUDE.md                    ← Agent 指令文件
├── SSOT-开发方法论-培训.pptx  ← 培训 PPT（宣传用）
└── ssot-convention.zh.md        ← 完整规范手册
```
