# SSOT Bootstrap

> 用 SSOT（Single Source of Truth）方法论快速创建项目或迁移现有项目的 Hermes Agent skill。

---

## 这是什么？

**SSOT Bootstrap** 是一个 [Hermes Agent](https://hermes-agent.nousresearch.com) skill，让你一句话完成：

```bash
# 新建 SSOT 项目
ssot-bootstrap new ../photo-app "学校照片SaaS"

# 迁移现有项目
ssot-bootstrap migrate ../legacy-project "遗留项目"
```

无需手动复制模板、无需记忆目录结构、无需替换占位符。AI 自动完成。

---

## 安装

### 方式 1：通过 Hermes 安装（推荐）

```bash
hermes curator install https://github.com/Toketec/ssot-bootstrap
```

然后在任何 Hermes 会话中：

```
ssot-bootstrap new ../my-project "我的项目"
```

### 方式 2：手动安装

```bash
git clone https://github.com/Toketec/ssot-bootstrap.git
cp -r ssot-bootstrap ~/.hermes/skills/
```

---

## 用法

### 创建新项目

```
ssot-bootstrap new <目标路径> [项目名称]
```

| 参数 | 必填 | 说明 |
|:----|:----:|:-----|
| `new` | ✅ | 创建模式 |
| `<目标路径>` | ✅ | 项目存放路径（相对或绝对） |
| `[项目名称]` | ❌ | 默认使用目录名 |

### 迁移现有项目

```
ssot-bootstrap migrate <目标路径> [项目名称]
```

迁移规则：
- ✅ 只添加 SSOT 骨架文件（AGENTS.md、模板目录等）
- ⛔ 不修改现有代码
- ⛔ 不改变现有目录结构
- ✅ 保留原有的 .gitignore、AGENTS.md（如已存在）

---

## 目录结构

新项目创建后：

```
project/
├── docs/                         # 稳定层：全版本通用产品文档
│   ├── product-overview.md       # 产品概览（模板）
│   ├── non-functional-reqs.md    # 非功能需求（模板）
│   ├── visual-design.md          # 视觉设计规范（模板）
│   └── sprints/                  # 版本层：每次迭代的完整设计容器
│       ├── _template/            # 冲刺模板（6文档+原型）
│       └── sprint-000_initial/   # v1.0 初始版本基线
│
├── apps/                         # 前端应用（含 specs/）
├── businesses/                   # 后端服务（含 specs/）
├── tools/                        # 工具脚本（含 specs/）
├── ADR/                          # 架构决策记录
├── AGENTS.md                     # AI 协作入口
├── ssot-convention.zh.md         # 完整规范手册
└── AI_USAGE.md                   # AI 使用指南
```

---

## 工作流程

```
Step 1 │ PM 写产品文档 + sprint 描述
       │ AI 辅助润色、画图、生成原型
       ▼
Step 2 │ Dev 给方向 → AI 写架构设计 + 规格四文件
       ▼
Step 3 │ PM + Dev 评审（AI 不参与）
       ▼
Step 4 │ AI 按 spec 编码 → 自检 → 展示改动 → 等确认
       ▼
Step 5 │ Dev 收尾 → QA 验收
```

详见项目内的 `AGENTS.md` 和 `ssot-convention.zh.md`。

---

## 依赖

- [Hermes Agent](https://hermes-agent.nousresearch.com) — AI 代理运行环境
- 网络连接（首次运行时从 GitHub 下载模板）
- `git`、`curl`、`bash`（标准工具）

---

## 相关项目

| 项目 | 说明 |
|:----|:-----|
| [ssot-methodology](https://github.com/Toketec/ssot-methodology) | SSOT 完整方法论模板（本 skill 拉取的源） |

---

## License

MIT
