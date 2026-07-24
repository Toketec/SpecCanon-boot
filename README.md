# SpecCanon-boot

> **通用项目引导工具** — 一行命令创建 SSOT 项目，自动适配所有 AI 环境。
>
> Hermes / Claude Code / Cursor / Codex CLI / Trae / OpenClaw / WorkBuddy 通用


## 核心设计

**一份方法论，适配所有 AI。**

```
conventions/ssot-skill.md         ← 唯一的 SSOT 方法论源头
        │
        ├── → AGENTS.md           (Hermes Agent)
        ├── → CLAUDE.md           (Claude Code)
        ├── → .cursorrules        (Cursor IDE)
        ├── → CODEX.md            (Codex CLI)
        ├── → .trae/rules/ssot.md (Trae)
        ├── → OPENCLAW.md         (OpenClaw)
        └── → WORKBUDDY.md        (WorkBuddy)
```

不再维护 N 套内容不同的约定文件。AI 初始化时根据 `ai-bridge/manifest.json` 的映射，把同一份方法论写入对应文件名。


## 一行命令（人手动用）

不克隆任何东西，直接在当前目录初始化：

```bash
# 创建新项目
curl -fsSL https://raw.githubusercontent.com/Toketec/SpecCanon-boot/main/init.sh | bash -s new ./my-app "我的项目"

# 指定 AI 环境
curl ... | bash -s new ./my-app "项目名" --ai cursor

# 迁移现有项目
curl ... | bash -s migrate ./legacy-project --ai claude-code

# 查看支持的 AI
curl ... | bash -s --list-ai
```

**自动检测规则**：优先环境变量（`HERMES_AGENT` / `CLAUDE_CODE` / `CURSOR` 等）→ 父进程名 → 兜底全生成。


## AI 用（通用 skill）

项目初始化后，当前 AI 会自动读取对应约定文件：

| AI | 读取文件 | 初始化命令 |
|:---|:---------|:-----------|
| **Hermes Agent** | `AGENTS.md` | `spec-canon-boot new ./app "项目名"` |
| **Claude Code** | `CLAUDE.md` | `/init.sh new ./app "项目名"` |
| **Cursor IDE** | `.cursorrules` | `/init.sh new ./app "项目名" --ai cursor` |
| **Codex CLI** | `CODEX.md` | `/init.sh new ./app "项目名" --ai codex` |
| **Trae** | `.trae/rules/ssot.md` | `/init.sh new ./app "项目名" --ai trae` |
| **OpenClaw** | `OPENCLAW.md` | `/init.sh new ./app "项目名" --ai openclaw` |
| **WorkBuddy** | `WORKBUDDY.md` | `/init.sh new ./app "项目名" --ai workbuddy` |

所有 AI 共享同一套五步流程：PM 出产品文档 → Dev+AI 出架构规格 → 评审 → AI 编码 → QA 验收。


## 安装（Hermes Agent）

```bash
hermes curator install https://github.com/Toketec/SpecCanon-boot
```

然后直接使用：

```
spec-canon-boot new ../photo-app "学校照片SaaS"
spec-canon-boot migrate ../legacy-project --ai trae
```


## 其它 AI 安装

无需安装。直接运行上文的一行命令，或让 AI 代理帮你执行：

```
请帮我用 SSOT Bootstrap 创建一个新项目 ./photo-app，名称叫"照片SaaS"
```

AI 会自动下载最新模板并生成项目骨架 + 适合当前 AI 的约定文件。


## 项目结构

```
SpecCanon-boot/
├── init.sh                 ★ 通用入口（curl-pipe-bash 安全）
├── SKILL.md                Hermes Skill 描述（通用 AI 代理也可参考）
├── README.md               本文件
├── LICENSE
├── scripts/
│   └── ssot-init.sh        ★ 核心初始化引擎
├── ai-bridge/
│   └── manifest.json        AI → 文件名映射表
├── conventions/
│   └── ssot-skill.md        ★ 通用 AI 方法论（唯一源头）
└── references/              参考文件
```


## 新项目生成后的目录结构

```
my-app/
├── AGENTS.md                通用 AI 方法论（所有 AI 都读这份）
├── CLAUDE.md                自动生成（如果是 Claude Code 环境）
├── .cursorrules             自动生成（如果是 Cursor 环境）
├── ...                      其他 AI 约定文件
├── docs/
│   ├── product-overview.md
│   ├── non-functional-reqs.md
│   ├── visual-design.md
│   └── sprints/
│       ├── _template/
│       └── sprint-000_initial/
├── apps/
├── businesses/
├── tools/
├── ADR/
├── ssot-convention.zh.md
└── README.md
```


## 五步开发流程

```
Step 1 │ PM 写产品文档 + 交互原型（纯业务，无技术方案）
Step 2 │ Dev 给方向 → AI 写 ADR + specs 四文件（架构设计）
Step 3 │ PM + Dev 评审（AI 不参与）
Step 4 │ AI 按 spec 编码 → 自检 → 展示改动 → 等确认
Step 5 │ Dev 收尾 → QA 验收
```


## License

MIT


## 相关项目

| 项目 | 说明 |
|:-----|:------|
| [SpecCanon](https://github.com/Toketec/SpecCanon) | SSOT 完整方法论模板（本工具拉取的源） |
