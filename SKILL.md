---
name: ssot-bootstrap
description: "SSOT 项目引导：从 GitHub 模板一键新建 SSOT 项目或迁移现有项目。支持两种模式：new <path> [name] 创建新项目，migrate <path> [name] 往现有项目嵌入 SSOT 骨架。"
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos]
metadata:
  hermes:
    tags: [ssot, bootstrap, template, project-init, migration]
    trigger_phrases: [
      "ssot-bootstrap",
      "ssot new",
      "ssot migrate",
      "创建ssot项目",
      "迁移到ssot",
      "ssot引导",
    ]
---

# SSOT Bootstrap — 项目引导 Skill

> **一句话**: 用 SSOT 方法论模板快速创建新项目，或给现有项目嵌入 SSOT 骨架。

---

## 触发条件

当用户说以下任意内容时，**必须加载本 skill**：
- "ssot-bootstrap new ../my-app" 或类似
- "ssot-bootstrap migrate ../existing-app" 或类似
- "用 SSOT 创建项目"、"新建 SSOT 项目"
- "把 X 项目迁移到 SSOT 规范"
- 任何包含 "ssot" + "创建"/"新建"/"迁移"/"引导" 的请求
- 模糊请求如 "帮我初始化项目" 且之前提到过 SSOT 方法论

---

## 两种操作模式

| 模式 | 命令 | 效果 |
|:----|:----|:----|
| **`new`** | `ssot-bootstrap new <目标路径> [项目名称]` | 创建完整的新项目 + SSOT 骨架 |
| **`migrate`** | `ssot-bootstrap migrate <目标路径> [项目名称]` | 在现有项目中嵌入 SSOT 骨架（不修改代码） |

---

## 步骤

### Step 0: 确认用户的意图

先确认用户要什么模式，以及目标项目路径和名称。示例：

> 用户: "帮我用 SSOT 新建个项目"
> AI: 好的，项目放哪里？项目名叫什么？
>
> 用户: "ssot-bootstrap new ../photo-app 学校照片系统"
> AI: 收到，开始创建。先获取模板...

### Step 1: 获取 SSOT 方法论模板

本 skill 携带一个自包含的引导脚本。执行它：

```bash
# 找到本 skill 目录下的脚本
SKILL_DIR="$(dirname "$(find ~/.hermes/skills -name "SKILL.md" -exec grep -l "ssot-bootstrap" {} \;)")"
SCRIPT="$SKILL_DIR/scripts/ssot-init.sh"

if [ ! -f "$SCRIPT" ]; then
  # 如果 skill 没有嵌入脚本（通过 curator install 安装的纯文本 skill），
  # 直接从 GitHub 拉取
  echo "从 GitHub 获取 ssot-init.sh..."
  curl -sL https://github.com/Toketec/ssot-bootstrap/raw/main/scripts/ssot-init.sh -o /tmp/ssot-init.sh
  chmod +x /tmp/ssot-init.sh
  SCRIPT="/tmp/ssot-init.sh"
fi
```

> **原理**: `ssot-init.sh` 会从 GitHub 下载最新的 ssot-methodology 模板到临时目录，然后运行引导脚本。如果你的机器上有本地 ssot-methodology 仓库，也可以直接使用。

### Step 2: 创建或迁移

#### 🔹 模式 new — 创建新项目

```bash
bash "$SCRIPT" new /absolute/path/to/new-project "项目名称"
```

脚本会自动：
1. 从 GitHub 拉取最新的 ssot-methodology 模板
2. 复制核心骨架（AGENTS.md, .gitignore）
3. 创建目录结构（apps/, businesses/, tools/, ADR/, docs/sprints/）
4. 复制 sprint 模板（_template + sprint-000_initial）
5. 替换所有 `{项目名}` 占位符为实际项目名

**完成后告诉用户：**
```
✅ SSOT 项目已创建: /path/to/new-project

下一步做什么？
1. cd /path/to/new-project
2. 编辑 docs/product-overview.md — 写产品概览
3. 创建第一个 sprint: cp -r docs/sprints/_template docs/sprints/sprint-001_name
4. 需要后端服务: cp -r businesses/_template businesses/my-service
5. 完整规范: cat ssot-convention.zh.md
```

#### 🔹 模式 migrate — 迁移现有项目

```bash
bash "$SCRIPT" migrate /absolute/path/to/existing-project "项目名称"
```

脚本会：
1. **不修改任何现有代码或文件**
2. 只添加 SSOT 骨架文件（如 AGENTS.md、目录结构、模板）
3. 如果已有 .gitignore 则保留，不覆盖

**完成后告诉用户：**
```
✅ SSOT 骨架已嵌入: /path/to/existing-project

迁移四阶段：
Phase 0: 骨架就位（已完成 ✅）
Phase 1: 为最核心的 3 个模块写 Retrospec
  - 在 apps/{module}/specs/ 或 businesses/{module}/specs/ 中
  - 只写 requirements + tasks + check（不写 plan.md）
  - 记录当前行为作为基线
Phase 2: 新功能强制走完整 SSOT 流程
  - PM 写 sprint → Dev 写 spec → AI 编码
Phase 3: 每次 sprint 选 1 个模块补 Retrospec
```

**⚠️ 迁移的关键规则**：
- 不要重写项目的现有文件
- 不要改变项目的现有目录结构
- 只添加 `AGENTS.md`、`docs/sprints/_template/`、`apps/`/`businesses/`/`tools/` 骨架目录
- 如果项目已有 src/ 目录，不要移动它

### Step 3: 后续引导

项目创建/迁移完成后，根据用户的技术栈和需求，引导下一步：

```bash
# 如果你知道用户的技术栈，直接生成建议：
# 前端: React / Vue / Next.js?
# 后端: Node.js / Go / Python?
# 数据库: PostgreSQL / MySQL / SQLite?
```

---

## 注意事项

### 1. 路径必须是绝对路径或相对当前工作目录的路径

```bash
# ✅ 正确
bash ssot-init.sh new /home/user/projects/my-app "我的应用"

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
ls "$HOME/ssot-methodology/scripts/bootstrap-project.sh" 2>/dev/null && echo "本地模板可用"
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

---

## 相关资源

| 资源 | 链接 |
|:----|:----|
| 本 skill 源码 | https://github.com/Toketec/ssot-bootstrap |
| SSOT 方法论模板 | https://github.com/Toketec/ssot-methodology |
| 完整规范手册 | `ssot-convention.zh.md`（在项目中） |
| Hermes 文档 | https://hermes-agent.nousresearch.com/docs |
