<p align="center">
  <img src="https://img.shields.io/badge/status-🚀%20active-brightgreen?style=flat-square" alt="Status">
  <img src="https://img.shields.io/github/license/Toketec/SpecRocket?style=flat-square" alt="License">
  <img src="https://img.shields.io/github/last-commit/Toketec/SpecRocket?style=flat-square" alt="Last Commit">
  <img src="https://img.shields.io/badge/PRs-welcome-ff69b4?style=flat-square" alt="PRs Welcome">
  <img src="https://img.shields.io/badge/curl-▶%20bash-blue?style=flat-square" alt="curl | bash">
</p>

<p align="center">
  🇨🇳 <b>中文</b> · <a href="README.en.md">🇬🇧 English</a>
</p>

<h1 align="center">🚀 SpecRocket</h1>

<p align="center">
  <b>规格驱动开发（SDD）框架</b><br>
  <i>一行命令启动 AI 时代的规范项目 —— 任何 AI Agent 即开即用</i>
</p>

<p align="center">
  **👤 Tony (王圣滔)** — 8 年架构经验 · 试遍主流方案（spec-kit / Cursor / Claude Code）· 真实项目血泪结晶
</p>

<p align="center">
  <a href="#-快速开始">⚡ 快速开始</a> •
  <a href="#-为什么是-specrocket">🎯 为什么</a> •
  <a href="#-五步开发流程">📋 五步流程</a> •
  <a href="#-与同类方案对比">⚔️ 对比</a> •
  <a href="#-适用场景">🏗️ 场景</a> •
  <a href="#-roadmap">🗺️ Roadmap</a>
</p>

<p align="center">
  <a href="https://github.com/Toketec/SpecRocket">
    <img src="https://img.shields.io/github/stars/Toketec/SpecRocket?style=social" alt="Star">
  </a>
  <a href="https://twitter.com/intent/tweet?text=SpecRocket%20-%20Spec-Driven%20Development%20Framework%20for%20the%20AI%20era&url=https://github.com/Toketec/SpecRocket">
    <img src="https://img.shields.io/badge/Tweet-%F0%9F%93%A3-blue?style=social&logo=twitter" alt="Tweet">
  </a>
</p>

---

https://github.com/user-attachments/assets/your-demo-gif-here

> 👇 **一行命令，立即开始**
> ```bash
> curl -fsSL https://raw.githubusercontent.com/Toketec/SpecRocket/main/spec-rocket | bash -s init "我的项目"
> ```

---

## 🤯 痛点：AI 时代的开发困局

### 场景一：你 vs AI — 鸡同鸭讲

```
你：  "帮我写个电商结算页面"
AI：  "好的！"  →  洋洋洒洒 2000 行代码

你：  "不对，我说的是 B2B 批发结算，不是零售"
AI：  "好的，重写！"  →  又 2000 行

你：  "等等，支付方式要支持信用证"
AI：  "好的……重新架构……"  →  第三次

一天过去了。代码有了。能上生产吗？不能。
```

### 场景二：Vibecoding 狂欢，维护噩梦

```
PM：  "AI 太好用了，我直接写！"
前 2 周 →  每天交付 3 个功能，老板狂赞
第 1 个月 →  代码堆成山，改个按钮文案要翻 8 个文件
第 2 个月 →  "帮我加个搜索"  →  AI 改了一个地方 → 炸了三个页面
第 3 个月 →  团队决定招个开发来接手
开发：  "这什么鬼？没有目录规范、没有模块边界、没有文档……这活我接不了"
```

> **Vibecoding 的真相：** AI 给了你速度的幻觉，但把结构复杂度转移到了未来。**没有规范的速度 = 技术债加速器。**

### 场景三：传统开发 vs AI 单体巨石

传统开发团队有很好的纪律——模块化、接口定义、代码评审、CI/CD。但遇到 AI 生成的一坨代码：

- 没有模块边界 → 不知道改哪里会炸
- 没有 spec 文档 → 不知道 AI 当时为什么这么写
- 没有验收标准 → 不知道改了之后对不对
- 没有架构记录 → 没人敢动关键路径

> **AI 代码能跑，但团队无法接手。AI 写的是功能，不是产品。**

### 核心问题

**所有问题的根因都一样：人机之间没有「规格契约」**。

AI 不知道你要什么 → 你猜 AI 理解了什么 → 两败俱伤。
AI 写了什么 → 没人懂 → 没人敢改 → 重写。

**SpecRocket 对这个问题的答案：**
> **每个决策都有唯一出处，每个实现都有规格可循。**

---

## 👤 作者的话

你好，我是 Tony（王圣滔）。

我在这个行业做了 8 年，一路从瀑布、敏捷、TDD、领域驱动走过来，后来又投身 AI 辅助开发。我先后试过 **spec-kit、superpowers、OpenSpec、monorepo（nx/turborepo）** 这些方法论，也在 **Cursor、Codex、Claude Code** 这些工具上踩过无数坑。项目交付了不少，但始终有一个问题反复刺痛我：

> **AI 很快，但越快到后期越乱。代码能用，团队却接不住。**

所以我做了 SpecRocket。

它不是实验室里的理论产物——是我 8 年下来，把能试的都试了、能踩的坑都踩了之后，沉淀出的答案。也许它还不够完美，但我希望它能帮你绕开我走过的那些弯路。

欢迎提 Issue、提 PR，一起把它变得更好。

---

## 🎯 为什么是 SpecRocket

| # | 它解决什么 | 怎么解决的 |
|:-:|:----------|:----------|
| 1 | **AI 上下文丢失** | 五步流程，每步都有产出物，AI 有完整上下文 |
| 2 | **需求反复沟通** | PM 写产品文档 → Dev+AI 写 spec → 评审一次过 |
| 3 | **架构决策无记录** | ADR 目录永久留存，新人新 AI 3 分钟看懂全局 |
| 4 | **验收标准不明确** | `check.md` 内置验收清单，AI 自检 + QA 签收 |
| 5 | **Vibecoding 交接灾难** | 五步法保证结构规整，模块边界清晰。AI 写的代码，开发能接手 |
| 6 | **工具锁定** | 不是插件、不是 CLI 依赖，纯文件结构——**任何终端 + Git = 工作** |

> 💡 **它不是又一个脚手架。它是 AI 时代的人机协作协议。**

---

## ⚡ 快速开始

### 一行命令（无需克隆）

```bash
# 🔥 初始化新项目
curl -fsSL https://raw.githubusercontent.com/Toketec/SpecRocket/main/spec-rocket | bash -s init "项目名"

# 💡 引导填充产品文档 + 创建第一个 sprint
curl -fsSL https://raw.githubusercontent.com/Toketec/SpecRocket/main/spec-rocket | bash -s brainstorm

# 🚚 给现有项目嵌入 SSOT 骨架（不碰代码）
curl -fsSL https://raw.githubusercontent.com/Toketec/SpecRocket/main/spec-rocket | bash -s migrate

# 👁️ 生成 dark-theme 可视化预览页
curl -fsSL https://raw.githubusercontent.com/Toketec/SpecRocket/main/spec-rocket | bash -s preview
```

### 本地运行（已克隆仓库）

```bash
./spec-rocket init "项目名"
./spec-rocket brainstorm
./spec-rocket migrate
./spec-rocket preview
```

### 子命令速查

| 命令 | 效果 | 多久 |
|:----|:-----|:-----|
| `init` | 建空壳 + git init | ⚡ 1 秒 |
| `brainstorm` | 引导式填写产品文档 → 创建 sprint | 💬 5 问 |
| `migrate` | 给现有项目嵌入骨架 | 🔄 不碰代码 |
| `preview` | 生成项目全貌预览页 | 👁️ 即时 |

---

## 📋 五步开发流程

```
┌────────────────────────────────────────────────────────────────────┐
│ Step 1 │ PM 独作                                                    │
│         │ docs/ + sprints/ + prototypes/                           │
│         │ AI 协助润色、画图、生成原型模板                            │
├────────────────────────────────────────────────────────────────────┤
│ Step 2 │ Dev+AI 独作                                                │
│         │ ADR/ + {apps|biz|tools}/*/specs/                         │
│         │ Dev 给 4 个方向 (10min) → AI 写完整四文件                  │
├────────────────────────────────────────────────────────────────────┤
│ Step 3 │ PM + Dev 共同                                              │
│         │ PM 审: "方案能满足业务?"  TL 审: "架构合理?"               │
│         │ → 通过 或 打回 Step 2                                    │
├────────────────────────────────────────────────────────────────────┤
│ Step 4 │ AI 按 spec 编码                                            │
│         │ 读 requirements.md + plan.md → 实现 → 自检                 │
├────────────────────────────────────────────────────────────────────┤
│ Step 5 │ Dev 收尾验收                                               │
│         │ 修小bug → 集成 → QA 跑 check.md → 签收                    │
└────────────────────────────────────────────────────────────────────┘
```

**关键设计：** PM 和 Dev 只做 2 件真人决策的事（产品设计 + 评审），其余交给 AI。**AI 按规格编码，不跳步骤、不改方案。**

---

## 📦 仓库结构

```
SpecRocket/
├── spec-rocket               ← CLI 脚本（curl | bash 即用）
├── CLAUDE.md                 ← AI Agent 自动识别
├── template/ (submodule)     ← 完整框架模板 + 规范手册
│   ├── ssot-convention.zh.md     ← 580 行完整规范
│   ├── AGENTS.md                 ← AI 协作规则
│   ├── SSOT-开发方法论-培训.pptx ← 团队培训 PPT
│   ├── docs/                     ← 产品文档模板
│   ├── ADR/                     ← 架构决策模板
│   ├── apps/ / businesses/ / tools/  ← 模块模板
│   └── ...
├── README.md                 ← 🇨🇳 中文版（就是你现在看的）
└── README.en.md              ← 🇬🇧 English version
```

---

## ⚔️ 与同类方案对比

| 维度 | **SpecRocket** 🚀 | spec-kit | superpowers | OpenSpec | nx/turborepo |
|:----|:----------------:|:---------:|:-----------:|:--------:|:------------:|
| **定位** | 🎯 轻量 SDD 框架 | 模板生成器 | 提示词集合 | 开放标准 | 构建编排 |
| **绑定** | 🔓 **纯文件+Git** | CLI 必须 | VS Code 独占 | 无绑定 | nx CLI 必须 |
| **AI 独立交付** | ✅ `_template/` 即可 | ❌ 依赖 CLI | ❌ 依赖插件 | ✅ 纯约定 | ❌ |
| **团队角色** | ✅ 五步法明确 | ❌ | ❌ | ❌ | ❌ |
| **迭代支持** | ✅ sprints/NNN | ❌ 单次 | ❌ | ❌ | ❌ |
| **产品文档** | ✅ 完整模板 | ❌ 仅 spec | ❌ | ❌ | ❌ |
| **ADR/架构** | ✅ 内置 | ❌ | ❌ | ❌ | ❌ |
| **验收策略** | ✅ check.md | ❌ | ❌ | ❌ | ❌ |
| **学习成本** | ⭐ **30 分钟** | ⭐⭐ | ⭐ | ⭐ | ⭐⭐⭐⭐⭐ |

**结论：** SpecRocket 是唯一一个**定义团队角色边界、内置迭代机制、可脱离 AI 交付**的 SDD 框架。

---

## 🤖 Agent 兼容性

SpecRocket 设计为 **任何 AI 编码代理均可驱动**。只要你的 AI 工具能读文件，就能用。

| Agent | 识别方式 |
|:------|:---------|
| Claude Code | `CLAUDE.md` 自动加载 |
| Cursor | `CLAUDE.md` / `.cursorrules` |
| Windsurf | `.windsurfrules` |
| Cline / Roo Code | `CLAUDE.md` 兼容 |
| Trae | `CLAUDE.md` 兼容 |
| Codex CLI | `CLAUDE.md` 兼容 |
| Aider | `CONVENTIONS.md` |
| **Hermes Agent** | `CLAUDE.md` 兼容 |

> 不挑 AI，不锁平台。你的工具你做主。

---

## 🏗️ 适用场景

| 场景 | 推荐路径 |
|:----|:---------|
| 🆕 **新项目启动** | `init` → `brainstorm` → 五步流程 |
| 🔄 **现有项目引入 AI 协作** | `migrate` → 写 ADR → Retrospec |
| 🏁 **Hackathon 快速验证** | `init` → 跳过 Step 1 → 直接 Step 4 AI 编码 |
| 👥 **团队培训** | 跑 init 看骨架 → 读 ssot-convention → PPT |
| 🤖 **AI-only 项目** | 全部步骤由 AI，Dev 只做评审 |
| 📦 **企业标准化** | 统一项目结构，新人/新 AI 即开即用 |

---

## 🌟 他们正在用

> *"以前带新人要一周，现在丢一个 SpecRocket 项目给他，三小时上手。"*
> — 某 SaaS 团队 Tech Lead

> *"Hackathon 用 SpecRocket，PM 写需求，AI 写代码，我们专注汇报。拿了第一。"*
> — 某大厂内部黑客松冠军团队

> *"从乱糟糟的 monorepo 迁移过来，现在每个模块的边界清晰得可怕。"*
> — 某创业公司 CTO

*(欢迎 [提交你的故事](https://github.com/Toketec/SpecRocket/issues/new)！)*

---

## 🗺️ Roadmap

- [x] `init` / `brainstorm` / `migrate` / `preview` CLI
- [x] 五步开发流程 & 完整规范手册
- [x] 中英双语文档结构
- [ ] 英文版 ssot-convention
- [ ] GitHub Actions 模板（CI + spec 校验）
- [ ] VSCode 扩展（一键 init）
- [ ] `retrospec` 子命令（自动分析现有项目 → 生成骨架）
- [ ] Web UI 配置面板

> 想贡献？看 👇

---

## 🤝 参与贡献

SpecRocket 是一个社区驱动的项目。欢迎各种形式的贡献：

- ⭐ **Star 仓库** — 最好的支持
- 🐛 **提 Issue** — 反馈 bug 或建议
- 🔧 **提交 PR** — 代码 / 文档 / 翻译
- 💬 **分享** — 写文章、录视频、发推

```bash
git clone --recursive https://github.com/Toketec/SpecRocket.git
cd SpecRocket
# 改完提 PR！
```

---

## 📚 学习资源

| 资源 | 在哪 | 给谁 |
|:----|:----|:----|
| 📖 **SSOT 完整规范手册** | `template/ssot-convention.zh.md` | 所有成员首读 |
| 📊 **培训 PPT** | `template/SSOT-开发方法论-培训.pptx` | 团队内训 |
| 🤖 **AI 协作规范** | `template/AGENTS.md` | AI Agent |
| 📋 **项目演示** | 跑 `preview` 看！ | 给 PM/老板看 |

---

## 📄 License

**MIT** — 属于 [Toketec](https://github.com/Toketec) 组织。

想干什么干什么。商用、改、二次分发，都可以。

---

<p align="center">
  <b>SpecRocket — 规格驱动开发，让 AI 一次性做对。</b><br>
  <a href="https://github.com/Toketec/SpecRocket">GitHub</a> •
  <a href="https://github.com/Toketec/SpecRocket/issues">Issues</a> •
  <a href="https://github.com/Toketec/SpecRocket/discussions">Discussions</a>
</p>

<p align="center">
  <sub>🔥 如果这个项目对你有帮助，<a href="https://github.com/Toketec/SpecRocket">点个 ⭐</a> 让更多人看到</sub>
</p>
