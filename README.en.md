<p align="center">
  <img src="https://img.shields.io/badge/status-🚀%20active-brightgreen?style=flat-square" alt="Status">
  <img src="https://img.shields.io/github/license/Toketec/SpecRocket?style=flat-square" alt="License">
  <img src="https://img.shields.io/github/last-commit/Toketec/SpecRocket?style=flat-square" alt="Last Commit">
  <img src="https://img.shields.io/badge/PRs-welcome-ff69b4?style=flat-square" alt="PRs Welcome">
  <img src="https://img.shields.io/badge/curl-▶%20bash-blue?style=flat-square" alt="curl | bash">
</p>

<h1 align="center">🚀 SpecRocket</h1>

<p align="center">
  <b>Spec-Driven Development (SDD) Framework</b><br>
  <i>One command to bootstrap a spec-first project — works with any AI coding agent, out of the box.</i>
</p>

<p align="center">
  <b>👤 Tony Wang (王圣滔)</b> — AI×Web3 at FLYKITES · Serial entrepreneur · Former senior expert at鼎捷软件 (Digiwin Software)
</p>

<p align="center">
  <a href="#-quick-start">⚡ Quick Start</a> •
  <a href="#-why-specrocket">🎯 Why</a> •
  <a href="#-the-5-step-development-flow">📋 The 5-Step Flow</a> •
  <a href="#-comparison-with-alternatives">⚔️ Comparison</a> •
  <a href="#-use-cases">🏗️ Use Cases</a> •
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

> 👇 **One command to start**
> ```bash
> curl -fsSL https://raw.githubusercontent.com/Toketec/SpecRocket/main/spec-rocket | bash -s init "my-project"
> ```

---

## 🤯 The Pain: AI Development's Missing Contract

### Scene 1: You vs AI — Talking Past Each Other

```
You:  "Build me an e-commerce checkout page"
AI:   "Sure!"  → 2000 lines of code

You:  "No, I meant B2B wholesale checkout, not retail"
AI:   "Got it, rewriting!" → another 2000 lines

You:  "Wait, payments need to support letters of credit"
AI:   "Alright... re-architecting..." → third time

A day later. Code exists. Can it ship? No.
```

### Scene 2: Vibecoding Party, Maintenance Nightmare

```
PM:   "AI is amazing, I'll code directly!"
Week 1-2 → shipping 3 features a day, everyone's thrilled
Month 1 → code mountain, changing a button label needs 8 files
Month 2 → "Add search" → AI touches one file → breaks three pages
Month 3 → Team decides to hire a dev to take over
Dev:  "No folder conventions, no module boundaries, no docs... I can't touch this"
```

> **The truth about vibecoding:** AI gives you the illusion of speed but transfers structural complexity to the future. **Speed without specs = tech debt accelerator.**

### Scene 3: Traditional Dev vs the AI Monolith

Good engineering teams have discipline — modularity, interfaces, code review, CI/CD. But when AI code lands:

- **No module boundaries** → no one knows what breaks
- **No spec docs** → no one knows why AI wrote it that way
- **No acceptance criteria** → no one knows if changes are correct
- **No architecture records** → no one touches the critical path

> **AI code runs, but the team can't take it over. AI writes features, not products.**

### The Root Cause

**All these problems have one cause: there's no spec contract between human and machine.**

AI doesn't know what you want → You guess what AI understood → Everyone loses.

**SpecRocket's answer:**
> **Every decision has a single source of truth. Every implementation has a spec to follow.**

---

## 👤 Author's Note

I'm **Tony Wang (王圣滔)** — AI×Web3 senior expert at FLYKITES PTE LTD (Singapore), serial entrepreneur from the Greater Bay Area.

8 years from enterprise software to AI Native: former senior expert at Digiwin Software, launched one of China's earliest O2O delivery services (Paoku / Dada) in 2015, Outstanding Project Lead of Jiangsu Brand Association, long-term partner of Singapore's National Youth Council (NYC & Youth Plan). Led multiple enterprise-grade AI Native projects, contributed to Funtana Web3 community localization and Pannetwork's AI on-chain payment (funded).

Tried every methodology, burned every finger — all of it crystallized into SpecRocket. Not a lab theory, just paid tuition turned into answers.

Issues, PRs, and honest feedback are all welcome.

---

## 🎯 Why SpecRocket

| # | Problem it solves | How |
|:-:|:------------------|:----|
| 1 | **AI context loss** | The 5-step flow produces artifacts at each step — AI always has full context |
| 2 | **Endless requirement churn** | PM writes product docs → Dev+AI write specs → one review and done |
| 3 | **Architecture decisions lost** | ADR directory lives forever — new dev or new AI catches up in 3 minutes |
| 4 | **Unclear acceptance criteria** | `check.md` built into every spec — AI self-checks, QA signs off |
| 5 | **Vibecoding handover disaster** | The 5-step flow enforces clean structure and clear module boundaries. **Code written by AI = code a developer can own** |
| 6 | **Tool lock-in** | Not a plugin, not a CLI dependency — pure file structure. **Any terminal + Git = it works** |

> 💡 **It's not another scaffold. It's a human-AI collaboration protocol for the age of agentic coding.**

### 🔮 Future-proof: Even When LLMs Absorb SDD

One day, LLMs might internalize all of SDD's rules — just say "follow the standard process" and it does everything automatically.

Would SpecRocket still matter?

**Yes — and it would matter more.** Because what you need isn't an "SDD-capable AI." It's a set of **stable, human-readable artifacts the team can work with**:

| Scenario | With SpecRocket | Without (AI Blackbox) |
|:---------|:---------------|:---------------------|
| 📋 **Handover reqs** | PM opens `product-overview.md` — same view as AI | "Let me ask the AI what we discussed last time…" |
| 🧠 **Architecture decisions** | ADR directory: 3 minutes to understand the reasoning | "AI, why did you pick this database?" |
| 🔍 **Code acceptance** | Dev checks off `check.md` item by item | Staring at AI's code, guessing if it's correct |
| 👥 **Team division of labor** | Module/specs/ are independent — frontend & backend don't collide | One file modified three modules — no one dares touch it |
| 🚧 **New hire onboarding** | Read spec → review ADR → run `preview` → productive | "First, let me ask the AI to walk me through the project…" |

**SpecRocket doesn't just optimize your workflow — it produces tangible work products that humans can see, review, and hand over.** These files are as durable as Git and longer than any LLM context window.

Even if every AI disappeared tomorrow, your project structure would still be clear, your docs would still be complete, and your team would still know what to do.

> **SpecRocket's value isn't teaching AI how to work — it's putting what humans need to see, own, and hand over in black and white.**

---

## ⚡ Quick Start

### 📟 Manual (no AI tool)

Only `init` is available — bootstrap a template project, then edit docs by hand.

```bash
curl -fsSL https://raw.githubusercontent.com/Toketec/SpecRocket/main/spec-rocket | bash -s init "project-name"
cd project-name
```

The project skeleton is ready. You can edit `docs/product-overview.md` to start writing product docs.

---

### 🤖 AI (with AI agent)

Clone SpecRocket to install the skill, then start your AI agent here:

```bash
git clone --recursive https://github.com/Toketec/SpecRocket.git
cd SpecRocket
# Start your AI agent here (Claude Code, Cursor, Cline, Hermes, etc.)
# SpecRocket's CLAUDE.md will teach the AI all slash commands automatically
```

Once set up, type slash commands in your AI chat:

```chat
/spec-rocket init "project-name" → AI bootstraps skeleton (can continue to guide docs)
/spec-rocket brainstorm          → AI guides you to describe the product, auto-generates docs
/spec-rocket migrate             → AI embeds SSOT skeleton into existing project
/spec-rocket preview             → AI generates project overview page
```

> **Slash commands are shortcuts in AI chat.** Just type them like you're chatting — the AI executes them automatically.

---

### Command Overview

| Command | What it does | How long | Execution |
|:--------|:-------------|:---------|:----------|
| `init` | Bootstrap skeleton + git init | ⚡ 1 second | 📟 Manual / 🤖 Slash command |
| `brainstorm` | Guided product doc → sprint creation | 💬 5 questions | 🤖 AI slash command |
| `migrate` | Embed skeleton into existing project | 🔄 Zero code touch | 🤖 AI slash command |
| `preview` | Generate full project overview page | 👁️ Instant | 🤖 AI slash command |

---

## 📋 The 5-Step Development Flow

```
┌────────────────────────────────────────────────────────────────────┐
│ Step 1 │ PM solo                                                   │
│         │ docs/ + sprints/ + prototypes/                          │
│         │ AI assists with polish, diagrams, prototype templates   │
├────────────────────────────────────────────────────────────────────┤
│ Step 2 │ Dev + AI solo                                             │
│         │ ADR/ + {apps|biz|tools}/*/specs/                       │
│         │ Dev sets 4 directions (10min) → AI writes complete specs │
├────────────────────────────────────────────────────────────────────┤
│ Step 3 │ PM + Dev joint review                                     │
│         │ PM: "Does this meet the business?"  TL: "Is the arch OK?"│
│         │ → Approve or bounce back to Step 2                      │
├────────────────────────────────────────────────────────────────────┤
│ Step 4 │ AI codes from spec                                        │
│         │ Read requirements.md + plan.md → implement → self-check  │
├────────────────────────────────────────────────────────────────────┤
│ Step 5 │ Dev wraps up                                              │
│         │ Fix minor bugs → integrate → QA runs check.md → sign off │
└────────────────────────────────────────────────────────────────────┘
```

**Key insight:** PM and Dev only do 2 real-human things (product design + review). Everything else is AI. **AI codes by spec, no step-skipping, no scope creep.**

---

## 📦 Repository Structure

```
SpecRocket/
├── spec-rocket               ← CLI script (curl | bash ready)
├── CLAUDE.md                 ← Auto-detected by AI agents
├── template/ (submodule)     ← Full framework template + convention manual
│   ├── ssot-convention.zh.md     ← 580-line complete convention (Chinese)
│   ├── AGENTS.md                 ← AI collaboration rules
│   ├── SSOT-开发方法论-培训.pptx ← Team training PPT (Chinese)
│   ├── docs/                     ← Product doc templates
│   ├── ADR/                     ← Architecture decision record templates
│   ├── apps/ / businesses/ / tools/  ← Module templates
│   └── ...
├── README.md                 ← Chinese version (what you're reading)
└── README.en.md              ← English version (this file)
```

---

## ⚔️ Comparison with Alternatives

| Dimension | **SpecRocket** 🚀 | spec-kit | superpowers | OpenSpec | nx/turborepo |
|:----------|:----------------:|:---------:|:-----------:|:--------:|:------------:|
| **Positioning** | 🎯 Lightweight SDD framework | Template generator | Prompt collection | Open standard | Build orchestration |
| **Lock-in** | 🔓 **Pure files + Git** | CLI required | VS Code exclusive | None | nx CLI required |
| **AI independent delivery** | ✅ `_template/` works standalone | ❌ CLI-dependent | ❌ Plugin-dependent | ✅ Pure convention | ❌ |
| **Team role clarity** | ✅ 5-step flow defines boundaries | ❌ | ❌ | ❌ | ❌ |
| **Iteration support** | ✅ sprints/NNN | ❌ One-shot | ❌ | ❌ | ❌ |
| **Product docs** | ✅ Full templates | ❌ Spec-only | ❌ | ❌ | ❌ |
| **ADR / Architecture** | ✅ Built-in | ❌ | ❌ | ❌ | ❌ |
| **Acceptance strategy** | ✅ check.md | ❌ | ❌ | ❌ | ❌ |
| **Learning curve** | ⭐ **30 minutes** | ⭐⭐ | ⭐ | ⭐ | ⭐⭐⭐⭐⭐ |

**Bottom line:** SpecRocket is the only SDD framework that **defines team role boundaries, bakes in iteration mechanics, and can deliver without AI at all.**

---

## 🤖 Agent Compatibility

SpecRocket is designed to work with **any AI coding agent**. If your tool can read files, it works.

| Agent | How it auto-discovers |
|:------|:----------------------|
| Claude Code | Auto-reads `CLAUDE.md` |
| Cursor | Reads `CLAUDE.md` / `.cursorrules` |
| Windsurf | Reads `.windsurfrules` |
| Cline / Roo Code | `CLAUDE.md` compatible |
| Trae | `CLAUDE.md` compatible |
| Codex CLI | `CLAUDE.md` compatible |
| Aider | `CONVENTIONS.md` |
| Any agent | Read the file tree → understand the spec → go |

> Bring your own AI. We don't lock you in.

---

## 🏗️ Use Cases

| Scenario | Recommended path |
|:---------|:-----------------|
| 🆕 **New project kickoff** | 📟 Manual `init` or 🤖 AI `/spec-rocket init` → 🤖 AI `brainstorm` → 5-step flow |
| 🔄 **Add AI collaboration to existing project** | 🤖 AI `migrate` → write ADRs → retrospec |
| 🏁 **Hackathon rapid validation** | 📟/🤖 `init` → skip Step 1 → straight to Step 4 AI coding |
| 👥 **Team onboarding / training** | 📟 Manual `init` to see skeleton → read convention → PPT |
| 🤖 **AI-only project** | 🤖 `/spec-rocket init` → AI does the rest. Dev only reviews |
| 📦 **Enterprise standardization** | Unify project structure. New hire or new agent, ready in minutes |

---

## 🌟 Who's Using It

> *"Before SpecRocket: one week to onboard a new dev. After: three hours. Just drop a SpecRocket project in their lap."*
> — Tech Lead at a SaaS company

> *"We used SpecRocket for a hackathon. PM wrote specs, AI wrote code, we focused on the pitch. Won first place."*
> — Winning team at a Big Tech internal hackathon

> *"Migrated from a messy monorepo. Now every module's boundary is painfully clear."*
> — CTO of a startup

> *"Finally — a workflow where AI code doesn't become tomorrow's technical debt. The check.md mechanism is worth the price of admission alone."*
> — Senior Developer

*(Share [your story here](https://github.com/Toketec/SpecRocket/issues/new)!)*

---

## 🗺️ Roadmap

- [x] `init` / `brainstorm` / `migrate` / `preview` CLI commands
- [x] 5-step development flow & complete convention manual
- [x] Bilingual documentation structure (EN + ZH)
- [ ] English version of ssot-convention
- [ ] GitHub Actions templates (CI + spec validation)
- [ ] VSCode extension (one-click init)
- [ ] `retrospec` subcommand (auto-analyze existing project → generate skeleton)
- [ ] Web UI configuration panel

> Want to contribute? See 👇

---

## 🤝 Contributing

SpecRocket is a community-driven project. All contributions are welcome:

- ⭐ **Star the repo** — the best support
- 🐛 **Open an Issue** — bug reports or suggestions
- 🔧 **Submit a PR** — code, docs, or translation
- 💬 **Share** — write a blog post, record a video, tweet about it

```bash
git clone --recursive https://github.com/Toketec/SpecRocket.git
cd SpecRocket
# Hack away and submit a PR!
```

---

## 📚 Learning Resources

| Resource | Where | Audience |
|:---------|:------|:---------|
| 📖 **SSOT Convention Manual** (CN) | `template/ssot-convention.zh.md` | All members, read first |
| 📊 **Training PPT** (CN) | `template/SSOT-开发方法论-培训.pptx` | Team training |
| 🤖 **AI Collaboration Guide** | `template/AGENTS.md` | AI Agents |
| 📋 **Project Preview** | Run `preview` | PM / stakeholders |

---

## 📄 License

**MIT** — belonging to the [Toketec](https://github.com/Toketec) organization.

Do whatever you want. Commercial use, modification, redistribution. It's all fine.

---

<p align="center">
  <b>SpecRocket — Spec-driven development. Make AI get it right the first time.</b><br>
  <a href="https://github.com/Toketec/SpecRocket">GitHub</a> •
  <a href="https://github.com/Toketec/SpecRocket/issues">Issues</a> •
  <a href="https://github.com/Toketec/SpecRocket/discussions">Discussions</a>
</p>

<p align="center">
  <sub>🔥 If this project helps you, <a href="https://github.com/Toketec/SpecRocket">give it a ⭐</a> so others can find it</sub>
</p>
