# 青年力量 standard-spec-framework 模板结构

> 来源：cnb.cool/youthpower.ltd/standard-spec-framework
> 分支：master
> 最后更新：2026-07-20（含 sprint + specs 模板确认）

## 目录树

```
standard-spec-framework/
├── docs/                          # PM 产品文档层
│   ├── product-overview.md        # 产品概览模板（含 {项目名} 占位符）
│   ├── non-functional-reqs.md     # 非功能需求模板（含 {占位符}）
│   ├── visual-design.md           # 视觉设计规范模板（含 {占位符}）
│   └── sprints/                   # 版本层 — 冲刺容器
│       ├── _template/             # ★ 冲刺模板（6文档 + prototypes/）
│       │   ├── SPRINT-features.md
│       │   ├── functional-overview.md
│       │   ├── user-scenarios.md
│       │   ├── ux-flows.md
│       │   ├── ui-wireframes.md
│       │   └── prototypes/
│       │       └── prototype.html
│       └── sprint-000_initial/    # ★ 初始版本基线模板（同上 6+1）
│           ├── SPRINT-features.md
│           ├── functional-overview.md
│           ├── user-scenarios.md
│           ├── ux-flows.md
│           ├── ui-wireframes.md
│           └── prototypes/
│               └── prototype.html
│
├── apps/                          # 前端应用模块
│   └── _template/
│       └── specs/                 # ★ 有四文件模板
│           ├── requirements.md    # 规格需求（含架构/边界/验收）
│           ├── plan.md            # 实现步骤+文件清单
│           ├── tasks.md           # 任务拆分+状态跟踪
│           └── check.md           # AI自检+人工验收
│
├── businesses/                    # 后端服务模块
│   └── _template/
│       └── specs/                 # ★ 有四文件模板
│           ├── requirements.md
│           ├── plan.md
│           ├── tasks.md
│           └── check.md
│
├── tools/                         # 工具脚本
│   └── _template/
│       └── specs/                 # ★ 有四文件模板
│           ├── requirements.md
│           ├── plan.md
│           ├── tasks.md
│           └── check.md
│
├── ADR/                           # 架构决策记录
│   └── _template/
│       └── ADR.md                 # ADR 模板文件
│
├── AGENTS.md                      # AI 协作入口（含完整五步流程说明）
├── development-guide.zh.md        # 完整规范手册（26 KB）
├── README.md                      # 项目说明
├── .gitignore
└── package.json                   # {"name": "standard-dev", "private": true}
```

## 与开源版 ssot-methodology 的差异

| 差异点 | 开源版 (Toketec) | 公司版 (cnb.cool) |
|:------|:----------------|:-----------------|
| 规范手册文件名 | `ssot-convention.zh.md` | `development-guide.zh.md` |
| *规范手册大小 | 约 10 KB | 约 26 KB（更详细） |
| 术语 | "SSOT" | "标准开发" |
| AGENTS.md 规范指引 | 指向 ssot-convention.zh.md | 指向 development-guide.zh.md |
| 培训 PPT | 无 | `开发方法论-培训.pptx`（376KB，汇报人王圣滔） |
| CI/CD | 无 | 无 |
| sprint 模板 | ✅ 完整 | ✅ 完整（2026-07-20 确认已存在） |
| specs 四文件 | ✅ 完整 | ✅ 完整（apps/businesses/tools 均有） |
| ADR 模板 | ✅ 有 | ✅ 有 |

## 关键文件内容摘要

### AGENTS.md
- 定义标准开发五步流程（PM → Dev+AI → 评审 → AI编码 → Dev收尾）
- 角色边界：PM 产出 docs/ + sprints/；Dev+AI 产出 ADR/ + specs/
- AI 执行规则：不跳 step、不改方案、人机协作
- 目录角色说明：稳定层(docs/) vs 版本层(sprints/) vs ADR/ vs specs/
- 约 70 行，markdown 格式

### development-guide.zh.md（26 KB）
- 完整规范手册，中文
- 包含：术语、角色矩阵、五步流程详解、文档模板说明、评审标准
- Dev 和 PM 都应阅读一次

## 模板使用要点

1. **占位符**：`{项目名}` 在 AGENTS.md 和 product-overview.md 中，创建项目后必须用 sed 替换
2. **sprint 模板**：`docs/sprints/_template/` 包含 6 个文档 + 1 个原型目录，创建新 sprint 时要 `cp -r` 整个目录
3. **specs 模板**：apps/businesses/tools 下的 `_template/specs/` 各有 4 个 spec 文件，按角色填写
4. **product-overview.md 必须填充**：模板含 {占位符}，创建项目后立即填充为真实产品描述，否则 AI 无法理解产品全貌

## 常见操作

```bash
# 创建新 sprint
cp -r docs/sprints/_template docs/sprints/sprint-001_name

# 创建新模块（后端）
cp -r businesses/_template businesses/my-service

# 创建新 ADR
cp ADR/_template/ADR.md ADR/ADR-002_some-decision.md
```
