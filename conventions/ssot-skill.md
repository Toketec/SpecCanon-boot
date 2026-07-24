# SSOT — 规格驱动开发方法论

> **通用 AI 协作指南** — 本文定义了 SSOT 五步开发流程和 AI 的执行规则。
> 任何 AI 代理接入此项目时均应加载本文件，遵循约定。

---

## 一、五步开发流程

```
Step 1 │ PM 独作: docs/ + sprints/ (产品文档+原型+冲刺)
Step 2 │ Dev+AI 独作: ADR/ + 模块/specs/ (架构设计+规格四文件)
Step 3 │ PM+Dev 碰面评审 → 通过 or 打回
Step 4 │ AI 按 spec 编码 → 自检 → 展示改动 → 等确认
Step 5 │ Dev 收尾 → QA 验收
```

## 二、目录架构

```
├── docs/             稳定层 — 全版本通用产品文档（概览/非功能/视觉）
├── docs/sprints/     版本层 — 每次迭代的完整设计容器
├── ADR/              架构决策记录（AI 先读此理解全局）
├── apps/*/specs/     前端应用规格
├── businesses/*/specs/ 后端服务规格
├── tools/*/specs/    工具规格
└── ssot-convention.zh.md  完整规范手册
```

## 三、各 Step AI 角色

### Step 1 (PM 产品设计)
- ✅ 可做：润色文档、画 ASCII 图、生成 HTML 原型模板、检查完整性
- ❌ 不可做：决定业务流程、定义验收条件、写技术方案

### Step 2 (Dev+AI 架构设计)
Dev 给 4 个方向决策后，AI 自动完成：
- `ADR/*.md` 架构设计
- `requirements.md` 技术方案+边界+验收
- `plan.md` 实现步骤+文件清单
- `tasks.md` 任务拆分
- `check.md` 自检+验收

### Step 3 (共同评审)
AI 不参与。纯人-人沟通。

### Step 4 (AI 编码)
1. 读 `requirements.md` → 理解方案
2. 按 `plan.md` 逐文件实现
3. 每步更新 `tasks.md` 状态
4. 完成 → `pnpm typecheck + pnpm build + curl` 自检
5. 展示改动 → **等用户确认** → 提交

### Step 5 (Dev 收尾)
AI 辅助修复边界 bug。

## 四、AI 执行守则

1. **读顺序**: 本文 → ADR/ → docs/sprints/ → 模块 specs/
2. **不跳 step**: 未经 Step 3 评审的 spec，不能进入 Step 4 编码
3. **不改方案**: 编码中发现 spec 有问题 → 停，通知回 Step 2/3
4. **人机协作**: 所有文件 AI 都可编辑。修改后展示改动，用户确认后提交
5. **不读全量 spec**: 只读 Context Contract（≤15 行）
6. **影响架构时更新 ADR**

## 五、Spec 四文件格式

| 文件 | 编写者 | 内容 |
|------|--------|------|
| `requirements.md` | Dev | 问题描述、边界（✅/❌）、依赖、验收标准、架构设计、数据模型、API 端点 |
| `plan.md` | Dev/TL | 步骤、文件清单、命令、注意事项、回滚方案 |
| `tasks.md` | Dev | 任务拆分、状态、Owner、工时 |
| `check.md` | Dev+QA | AI 自检命令、人工验证步骤、回归范围 |

### Retrospec（存量代码迁移）
只写 3 文件：`requirements.md` + `tasks.md` + `check.md`，不写 `plan.md`。

## 六、禁止项

1. ❌ 禁止自动 `git commit` 或 `git push`
2. ❌ AI 不得自行签署验收（check.md 需 Dev/QA 跑）
3. ❌ Step 1 不允许写技术方案或代码
