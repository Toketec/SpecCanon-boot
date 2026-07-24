#!/usr/bin/env bash
# ============================================================================
# SSOT Init — SSOT 项目自包含引导脚本
# ============================================================================
# 本脚本是 init.sh 的引擎内核（保持向后兼容），被 skill 和 init.sh 共同调用。
# 用法:
#   ssot-init.sh new <目标路径> [项目名称] [--ai <AI类型>]
#   ssot-init.sh migrate <目标路径> [项目名称] [--ai <AI类型>]
#
# 示例:
#   ssot-init.sh new ../my-app "我的应用"
#   ssot-init.sh new ../my-app "我的应用" --ai claude-code
#   ssot-init.sh migrate ../legacy-project
# ============================================================================

set -euo pipefail

SSOT_REPO="https://github.com/Toketec/SpecCanon.git"
BOOTSTRAP_REPO="https://github.com/Toketec/SpecCanon-boot.git"
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[1;33m'
COLOR_CYAN='\033[0;36m'
COLOR_RED='\033[0;31m'
COLOR_NC='\033[0m'

# ─── AI 映射表 ──────────────────────────────────
declare -A AI_FILE AI_ENV AI_PROC AI_NAME
AI_FILE[hermes]="AGENTS.md"
AI_FILE[claude-code]="CLAUDE.md"
AI_FILE[codex]="CODEX.md"
AI_FILE[cursor]=".cursorrules"
AI_FILE[openclaw]="OPENCLAW.md"
AI_FILE[workbuddy]="WORKBUDDY.md"
AI_FILE[trae]=".trae/rules/ssot.md"

AI_ENV[hermes]="HERMES_AGENT"
AI_ENV[claude-code]="CLAUDE_CODE"
AI_ENV[codex]="CODEX_CLI"
AI_ENV[cursor]="CURSOR"
AI_ENV[openclaw]="OPENCLAW"
AI_ENV[workbuddy]="WORKBUDDY"
AI_ENV[trae]="TRAE"

AI_PROC[hermes]="hermes"
AI_PROC[claude-code]="claude"
AI_PROC[codex]="codex"
AI_PROC[cursor]="cursor"
AI_PROC[openclaw]="openclaw"
AI_PROC[workbuddy]="workbuddy"
AI_PROC[trae]="trae"

AI_NAME[hermes]="Hermes Agent"
AI_NAME[claude-code]="Claude Code (Anthropic)"
AI_NAME[codex]="OpenAI Codex CLI"
AI_NAME[cursor]="Cursor IDE"
AI_NAME[openclaw]="OpenClaw"
AI_NAME[workbuddy]="WorkBuddy"
AI_NAME[trae]="Trae (ByteDance)"

ALL_AIS=("hermes" "claude-code" "codex" "cursor" "openclaw" "workbuddy" "trae")

echo -e "${COLOR_CYAN}╔══════════════════════════════════════════╗${COLOR_NC}"
echo -e "${COLOR_CYAN}║   SSOT Bootstrap v2 — 通用项目引导       ║${COLOR_NC}"
echo -e "${COLOR_CYAN}╚══════════════════════════════════════════╝${COLOR_NC}"
echo ""

# ─── 参数解析 ───────────────────────────────────
usage() {
    echo "用法: $0 {new|migrate} <目标路径> [项目名称] [--ai <AI类型>]"
    echo ""
    echo "  new       — 创建全新 SSOT 项目"
    echo "  migrate   — 在现有项目中嵌入 SSOT 骨架"
    echo "  --ai      — 指定 AI 环境（默认自动检测）"
    echo ""
    echo "示例:"
    echo "  $0 new  ../my-app \"我的应用\""
    echo "  $0 migrate ../legacy-project \"遗留项目\""
    echo "  $0 new ../my-app \"我的应用\" --ai claude-code"
    exit 1
}

MODE=""; TARGET=""; PROJECT_NAME=""; SPECIFIED_AI=""
while [ $# -gt 0 ]; do
    case "$1" in
        new|migrate) MODE="$1"; shift ;;
        --ai) SPECIFIED_AI="$2"; shift 2 ;;
        --help|-h) usage ;;
        -*)
            echo -e "${COLOR_RED}未知选项: $1${COLOR_NC}"; usage ;;
        *)
            [ -z "$TARGET" ] && TARGET="$1" || [ -z "$PROJECT_NAME" ] && PROJECT_NAME="$1"
            shift ;;
    esac
done
[ -z "$MODE" ] || [ -z "$TARGET" ] && usage

TARGET="$(realpath "$TARGET" 2>/dev/null || echo "$TARGET")"
PROJECT_NAME="${PROJECT_NAME:-$(basename "$TARGET")}"

MODE_LABEL="创建新项目"
[ "$MODE" = "migrate" ] && MODE_LABEL="迁移现有项目"

echo -e "${COLOR_YELLOW}→ 模式:${COLOR_NC} $MODE_LABEL"
echo -e "${COLOR_YELLOW}→ 目标:${COLOR_NC} $TARGET"
echo -e "${COLOR_YELLOW}→ 项目:${COLOR_NC} $PROJECT_NAME"

# ─── AI 自动检测 ──────────────────────────────
detect_ai() {
    local ai_name
    for ai_name in "${ALL_AIS[@]}"; do
        local env_var="${AI_ENV[$ai_name]}"
        if [ -n "${!env_var:-}" ]; then echo "$ai_name"; return; fi
    done
    if command -v ps &>/dev/null; then
        local ppid_name=$(ps -o comm= -p $PPID 2>/dev/null || ps -o args= -p $PPID 2>/dev/null || echo "")
        for ai_name in "${ALL_AIS[@]}"; do
            if echo "$ppid_name" | grep -qi "${AI_PROC[$ai_name]}"; then echo "$ai_name"; return; fi
        done
    fi
    echo "all"
}

if [ -n "$SPECIFIED_AI" ]; then
    SELECTED_AI="$SPECIFIED_AI"
    echo -e "${COLOR_YELLOW}→ AI:${COLOR_NC} $SELECTED_AI"
else
    SELECTED_AI=$(detect_ai)
    echo -e "${COLOR_YELLOW}→ AI:${COLOR_NC} $SELECTED_AI (自动检测)"
fi
echo ""

# ─── 获取模板 ───────────────────────────────────
TMPDIR=""
cleanup() { [ -n "$TMPDIR" ] && rm -rf "$TMPDIR" 2>/dev/null || true; }
trap cleanup EXIT

echo -e "${COLOR_GREEN}[1/5]${COLOR_NC} 获取 SSOT 方法论模板..."

# 检查本地模板（更快）
LOCAL_METHODOLOGY=""
<<<<<<< HEAD
for candidate in \
    "$HOME/SpecCanon" \
    "$(dirname "$0")/../SpecCanon" \
    "$(pwd)/SpecCanon"; do
    if [ -f "$candidate/scripts/bootstrap-project.sh" ]; then
        LOCAL_METHODOLOGY="$candidate"
        echo "  找到本地模板: $LOCAL_METHODOLOGY"
        break
    fi
=======
for candidate in "$HOME/SpecCanon" "$(dirname "$0")/../SpecCanon" "$(pwd)/SpecCanon"; do
    [ -f "$candidate/scripts/bootstrap-project.sh" ] && { LOCAL_METHODOLOGY="$candidate"; break; }
>>>>>>> 9bc03ef (feat: v2.0 — 通用多 AI 初始化系统)
done

METHODOLOGY_DIR=""
if [ -n "$LOCAL_METHODOLOGY" ]; then
    METHODOLOGY_DIR="$LOCAL_METHODOLOGY"
    echo "  使用本地模板: $METHODOLOGY_DIR"
else
    TMPDIR="$(mktemp -d)"
    echo "  ↓ 从 GitHub 下载模板..."
    if git clone --depth 1 "$SSOT_REPO" "$TMPDIR/SpecCanon" 2>/dev/null; then
        METHODOLOGY_DIR="$TMPDIR/SpecCanon"
        echo "  ✅ 模板下载完成"
    else
        echo -e "${COLOR_RED}  ❌ 从 GitHub 克隆失败。检查网络连接或代理。${COLOR_NC}"
        echo "  你也可以先手动克隆:"
        echo "    git clone $SSOT_REPO \$HOME/SpecCanon"
        exit 1
    fi
fi

# ─── 准备目标目录 ───────────────────────────────
echo -e "${COLOR_GREEN}[2/5]${COLOR_NC} 准备目标目录..."
if [ "$MODE" = "new" ]; then
    mkdir -p "$TARGET"
    echo "  ✅ 目录已创建: $TARGET"
else
    [ ! -d "$TARGET" ] && { echo -e "${COLOR_RED}  ❌ 目标目录不存在: $TARGET${COLOR_NC}"; exit 1; }
    echo "  ✅ 目标已存在"
fi

# ─── 复制核心骨架 ───────────────────────────────
echo -e "${COLOR_GREEN}[3/5]${COLOR_NC} 复制核心文件..."

# AGENTS.md（用通用 skill 内容）
if [ ! -f "$TARGET/AGENTS.md" ]; then
    SKILL_CONTENT=""
    # 优先从本 skill 目录获取
    SKILL_DIR="$(dirname "$0")/.."
    if [ -f "$SKILL_DIR/conventions/ssot-skill.md" ]; then
        cp "$SKILL_DIR/conventions/ssot-skill.md" "$TARGET/AGENTS.md"
        SKILL_CONTENT="ok"
        echo "  ✅ AGENTS.md（通用 AI 方法论）"
    elif curl -fsSL "$BOOTSTRAP_REPO/raw/main/conventions/ssot-skill.md" -o "$TARGET/AGENTS.md" 2>/dev/null; then
        echo "  ✅ AGENTS.md（通用 AI 方法论）"
    else
        cp "$METHODOLOGY_DIR/AGENTS.md" "$TARGET/AGENTS.md"
        echo "  ✅ AGENTS.md（模板版）"
    fi
else
    echo "  ⏭️  AGENTS.md 已存在，跳过"
fi

# ssot-convention.zh.md
if [ ! -f "$TARGET/ssot-convention.zh.md" ]; then
    cp "$METHODOLOGY_DIR/ssot-convention.zh.md" "$TARGET/ssot-convention.zh.md"
    echo "  ✅ ssot-convention.zh.md"
fi

# .gitignore
if [ ! -f "$TARGET/.gitignore" ]; then
    cp "$METHODOLOGY_DIR/.gitignore" "$TARGET/.gitignore" 2>/dev/null || true
    echo "  ✅ .gitignore"
fi

<<<<<<< HEAD
# ─── 创建目录结构 ──────────────────────────────────
=======
# ─── 创建目录结构 ───────────────────────────────
>>>>>>> 9bc03ef (feat: v2.0 — 通用多 AI 初始化系统)
echo -e "${COLOR_GREEN}[4/5]${COLOR_NC} 创建目录结构..."

if [ ! -d "$TARGET/docs" ]; then
    mkdir -p "$TARGET/docs"
    for doc in product-overview.md non-functional-reqs.md visual-design.md; do
        [ -f "$METHODOLOGY_DIR/docs/$doc" ] && cp "$METHODOLOGY_DIR/docs/$doc" "$TARGET/docs/$doc" && echo "  ✅ docs/$doc"
    done
fi

mkdir -p "$TARGET/docs/sprints"
[ -d "$METHODOLOGY_DIR/docs/sprints/_template" ] && [ ! -d "$TARGET/docs/sprints/_template" ] && cp -r "$METHODOLOGY_DIR/docs/sprints/_template" "$TARGET/docs/sprints/" && echo "  ✅ docs/sprints/_template/"
[ -d "$METHODOLOGY_DIR/docs/sprints/sprint-000_initial" ] && [ ! -d "$TARGET/docs/sprints/sprint-000_initial" ] && cp -r "$METHODOLOGY_DIR/docs/sprints/sprint-000_initial" "$TARGET/docs/sprints/" && echo "  ✅ docs/sprints/sprint-000_initial/"

for dir in apps businesses tools; do
    if [ ! -d "$TARGET/$dir" ]; then
        mkdir -p "$TARGET/$dir/_template/specs"
        [ -f "$METHODOLOGY_DIR/$dir/_template/specs/requirements.md" ] && cp "$METHODOLOGY_DIR/$dir/_template/specs/"* "$TARGET/$dir/_template/specs/" 2>/dev/null || true
        touch "$TARGET/$dir/.gitkeep"
        echo "  ✅ $dir/"
    fi
done

[ ! -d "$TARGET/ADR" ] && mkdir -p "$TARGET/ADR/_template" && [ -f "$METHODOLOGY_DIR/ADR/_template/ADR.md" ] && cp "$METHODOLOGY_DIR/ADR/_template/ADR.md" "$TARGET/ADR/_template/ADR.md" && echo "  ✅ ADR/"

# ─── 生成 AI 约定文件 ────────────────────────
echo -e "${COLOR_GREEN}[5/5]${COLOR_NC} 生成 AI 约定文件..."

generate_ai_file() {
    local ai=$1 sf="${AI_FILE[$ai]}" tp=""
    [ -z "$sf" ] && return
    tp="$TARGET/$sf"
    [ -f "$tp" ] && return
    mkdir -p "$(dirname "$tp")"

    local content=$(cat "$TARGET/AGENTS.md" 2>/dev/null || cat "$SKILL_DIR/conventions/ssot-skill.md" 2>/dev/null || curl -fsSL "$BOOTSTRAP_REPO/raw/main/conventions/ssot-skill.md" 2>/dev/null || true)
    [ -z "$content" ] && return

    {
        echo "# $sf — SSOT ${AI_NAME[$ai]:-$ai} 协作入口"
        echo "# 从通用方法论语: conventions/ssot-skill.md"
        echo "# 完整规范: ssot-convention.zh.md"
        echo ""
        echo "$content"
    } > "$tp"
    echo "  ✅ $sf (${AI_NAME[$ai]:-$ai})"
}

if [ "$SELECTED_AI" = "all" ]; then
    for ai in "${ALL_AIS[@]}"; do generate_ai_file "$ai"; done
    echo "  📌 生成了所有 AI 的约定文件（可删除不需要的）。"
else
    generate_ai_file "$SELECTED_AI"
fi

# ─── 替换占位符 ───────────────────────────────
[[ "$OSTYPE" == "darwin"* ]] \
    && find "$TARGET" -name "*.md" -not -path "*/node_modules/*" -exec sed -i '' "s/{项目名}/$PROJECT_NAME/g" {} \; 2>/dev/null || true \
    && find "$TARGET" -name "*.md" -not -path "*/node_modules/*" -exec sed -i '' "s/{Project Name}/$PROJECT_NAME/g" {} \; 2>/dev/null || true \
    || find "$TARGET" -name "*.md" -not -path "*/node_modules/*" -exec sed -i "s/{项目名}/$PROJECT_NAME/g" {} \; 2>/dev/null || true \
    && find "$TARGET" -name "*.md" -not -path "*/node_modules/*" -exec sed -i "s/{Project Name}/$PROJECT_NAME/g" {} \; 2>/dev/null || true

echo ""
echo -e "${COLOR_GREEN}✅ 完成!${COLOR_NC}"
echo -e "${COLOR_CYAN}   目标: $TARGET${COLOR_NC}"
echo ""

# ─── 后续指引 ──────────────────────────────────
echo -e "${COLOR_CYAN}下一步:${COLOR_NC}"
echo "  1. cd $TARGET"
echo "  2. 编辑 docs/product-overview.md 写产品概览"
echo "  3. 创建第一个 sprint:"
echo "     cp -r docs/sprints/_template docs/sprints/sprint-001_name"
echo "  4. 创建模块:"
echo "     cp -r apps/_template apps/my-app"
echo "     cp -r businesses/_template businesses/my-service"
echo "  5. 完整规范: cat ssot-convention.zh.md"
echo ""
if [ "$SELECTED_AI" != "all" ] && [ -n "${AI_FILE[$SELECTED_AI]:-}" ]; then
    echo -e "${COLOR_CYAN}AI 协作:${COLOR_NC}"
    echo "  当前 AI (${AI_NAME[$SELECTED_AI]}) 的约定文件: ${AI_FILE[$SELECTED_AI]}"
    echo "  已包含完整 SSOT 方法论。"
    echo ""
fi

if [ "$MODE" = "migrate" ]; then
    echo -e "${COLOR_YELLOW}迁移注意:${COLOR_NC}"
    echo "  Phase 0: 骨架就位（✅ 已完成）"
    echo "  Phase 1: 为核心模块写 Retrospec（3 文件，无 plan.md）"
    echo "  Phase 2: 新功能走完整 SSOT 流程"
    echo "  ⚠ 本脚本没有修改你现有的任何代码。"
fi
