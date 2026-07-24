#!/usr/bin/env bash
# ============================================================================
# SSOT Bootstrap 通用初始化脚本
# ============================================================================
# 一行命令创建 SSOT 项目（无需克隆任何仓库）:
#
#   curl -fsSL https://raw.githubusercontent.com/Toketec/SpecCanon-boot/main/init.sh | bash -s new ./my-app "项目名"
#
# 模式:
#   new     — 创建全新 SSOT 项目
#   migrate — 在现有项目中嵌入 SSOT 骨架
#
# 选项:
#   --ai <name>  指定 AI 环境（自动检测时可选: hermes/claude-code/cursor/codex/...）
#   --list-ai    列出支持的 AI 环境
#
# 示例:
#   curl ... | bash -s new ./photo-app "学校照片SaaS"
#   curl ... | bash -s new ./photo-app "学校照片SaaS" --ai cursor
#   curl ... | bash -s migrate ./existing-project --ai claude-code
# ============================================================================
# 此脚本是自包含的——不依赖本地文件、不克隆仓库、仅需 curl+git+bash。
# 它从 GitHub 获取最新的 SpecCanon 模板，然后创建项目骨架。
# 完成后，自动根据当前 AI 环境生成对应的约定文件（AGENTS.md / CLAUDE.md / ...）。
# ============================================================================

set -euo pipefail

# ─── 颜色 ─────────────────────────────────────────┈─
C_GREEN='\033[0;32m'; C_YELLOW='\033[1;33m'
C_CYAN='\033[0;36m'; C_RED='\033[0;31m'; C_NC='\033[0m'

echo -e "${C_CYAN}╔══════════════════════════════════════════╗${C_NC}"
echo -e "${C_CYAN}║   SSOT Bootstrap — 通用项目引导           ║${C_NC}"
echo -e "${C_CYAN}╚══════════════════════════════════════════╝${C_NC}"
echo ""

# ─── 配置常量 ────────────────────────────────────
SSOT_REPO="https://github.com/Toketec/SpecCanon.git"
BOOTSTRAP_REPO="https://github.com/Toketec/SpecCanon-boot.git"

# ─── AI 映射表（与 ai-bridge/manifest.json 同步） ──
declare -A AI_FILE
declare -A AI_ENV
declare -A AI_PROC
declare -A AI_NAME

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

# ─── 工具函数 ──────────────────────────────────
usage() {
    echo "用法: init.sh {new|migrate} <目标路径> [项目名称] [--ai <AI类型>]"
    echo ""
    echo "模式:"
    echo "  new      创建全新 SSOT 项目"
    echo "  migrate  在现有项目中嵌入 SSOT 骨架（不修改原代码）"
    echo ""
    echo "选项:"
    echo "  --ai <name>  指定 AI 环境（默认自动检测）"
    echo "  --list-ai    列出所有支持的 AI 环境"
    echo ""
    echo "一行命令示例:"
    echo "  curl -fsSL https://raw.githubusercontent.com/Toketec/SpecCanon-boot/main/init.sh | bash -s new ./photo-app '照片SaaS'"
    exit 1
}

list_ai() {
    echo -e "${C_CYAN}支持的 AI 环境:${C_NC}"
    echo ""
    printf "  %-16s %-24s %s\n" "AI名称" "约定文件" "描述"
    printf "  %-16s %-24s %s\n" "--------" "--------" "----"
    for ai in "${ALL_AIS[@]}"; do
        printf "  %-16s %-24s %s\n" "$ai" "${AI_FILE[$ai]}" "${AI_NAME[$ai]}"
    done
    echo ""
    echo "不指定 --ai 时会自动检测。"
    exit 0
}

# ─── 参数解析 ──────────────────────────────────
MODE=""
TARGET=""
PROJECT_NAME=""
SPECIFIED_AI=""

while [ $# -gt 0 ]; do
    case "$1" in
        new|migrate) MODE="$1"; shift ;;
        --ai) SPECIFIED_AI="$2"; shift 2 ;;
        --list-ai) list_ai ;;
        --help|-h) usage ;;
        -*)
            echo -e "${C_RED}未知选项: $1${C_NC}"; usage ;;
        *)
            if [ -z "$TARGET" ]; then
                TARGET="$1"
            elif [ -z "$PROJECT_NAME" ]; then
                PROJECT_NAME="$1"
            fi
            shift ;;
    esac
done

if [ -z "$MODE" ] || [ -z "$TARGET" ]; then
    usage
fi

if [ -z "$PROJECT_NAME" ]; then
    PROJECT_NAME=$(basename "$TARGET")
fi

# ─── AI 自动检测 ──────────────────────────────
detect_ai() {
    local ai=""
    local ai_name

    # 1. 环境变量检测
    for ai_name in "${ALL_AIS[@]}"; do
        env_var="${AI_ENV[$ai_name]}"
        if [ -n "${!env_var:-}" ]; then
            echo "$ai_name"
            return
        fi
    done

    # 2. 父进程名检测
    local ppid_name=""
    if command -v ps &>/dev/null; then
        ppid_name=$(ps -o comm= -p $PPID 2>/dev/null || ps -o args= -p $PPID 2>/dev/null || echo "")
        for ai_name in "${ALL_AIS[@]}"; do
            proc_pattern="${AI_PROC[$ai_name]}"
            if echo "$ppid_name" | grep -qi "$proc_pattern"; then
                echo "$ai_name"
                return
            fi
        done
    fi

    # 3. 当前进程名检测
    local cur_name=""
    if command -v ps &>/dev/null; then
        cur_name=$(ps -o comm= -p $$ 2>/dev/null || echo "")
        for ai_name in "${ALL_AIS[@]}"; do
            proc_pattern="${AI_PROC[$ai_name]}"
            if echo "$cur_name" | grep -qi "$proc_pattern"; then
                echo "$ai_name"
                return
            fi
        done
    fi

    # 4. 默认：全生成（不偏好某一种）
    echo "all"
}

# ─── 用绝对路径解析目标 ──────────────────────
if [[ "$TARGET" != /* ]]; then
    TARGET="$(cd "$(pwd)" 2>/dev/null && pwd)/$TARGET"
fi

MODE_LABEL="创建新项目"
[ "$MODE" = "migrate" ] && MODE_LABEL="迁移现有项目"

echo -e "${C_YELLOW}→ 模式:${C_NC} $MODE_LABEL"
echo -e "${C_YELLOW}→ 目标:${C_NC} $TARGET"
echo -e "${C_YELLOW}→ 项目:${C_NC} $PROJECT_NAME"

# ─── 确定 AI 类型 ──────────────────────────────
if [ -n "$SPECIFIED_AI" ]; then
    SELECTED_AI="$SPECIFIED_AI"
    echo -e "${C_YELLOW}→ 指定 AI:${C_NC} $SELECTED_AI"
else
    SELECTED_AI=$(detect_ai)
    echo -e "${C_YELLOW}→ 检测到 AI:${C_NC} $SELECTED_AI"
fi
echo ""

# ─── 步骤 1: 获取模板 ─────────────────────────
TMPDIR=""
cleanup() { [ -n "$TMPDIR" ] && rm -rf "$TMPDIR" 2>/dev/null || true; }
trap cleanup EXIT

echo -e "${C_GREEN}[1/5] 获取 SSOT 方法论模板...${C_NC}"

TMPDIR=$(mktemp -d)
echo "  ↓ 从 GitHub 克隆模板..."

if git clone --depth 1 "$SSOT_REPO" "$TMPDIR/SpecCanon" 2>/dev/null; then
    echo "  ✅ 模板下载完成"
else
    echo -e "${C_RED}  ❌ 下载失败。检查网络连接。${C_NC}"
    exit 1
fi

METHODOLOGY_DIR="$TMPDIR/SpecCanon"

# ─── 步骤 2: 准备目标目录 ─────────────────────
echo -e "${C_GREEN}[2/5] 准备目标目录...${C_NC}"
if [ "$MODE" = "new" ]; then
    mkdir -p "$TARGET"
    echo "  ✅ 目录已创建: $TARGET"
else
    if [ ! -d "$TARGET" ]; then
        echo -e "${C_RED}  ❌ 目标目录不存在: $TARGET${C_NC}"
        exit 1
    fi
    echo "  ✅ 目标已存在"
fi

# ─── 步骤 3: 复制核心骨架 ─────────────────────
echo -e "${C_GREEN}[3/5] 复制核心文件...${C_NC}"

# AGENTS.md（用通用 skill 内容）
if [ ! -f "$TARGET/AGENTS.md" ]; then
    if curl -fsSL "https://raw.githubusercontent.com/Toketec/SpecCanon-boot/main/conventions/ssot-skill.md" -o "$TARGET/AGENTS.md" 2>/dev/null; then
        echo "  ✅ AGENTS.md（通用方法论）"
    else
        echo -e "${C_YELLOW}  ⚠ 从 GitHub 获取 AGENTS.md 失败，克隆后再拷贝...${C_NC}"
        git clone --depth 1 "$BOOTSTRAP_REPO" "$TMPDIR/SpecCanon-boot" 2>/dev/null || true
        if [ -f "$TMPDIR/SpecCanon-boot/conventions/ssot-skill.md" ]; then
            cp "$TMPDIR/SpecCanon-boot/conventions/ssot-skill.md" "$TARGET/AGENTS.md"
            echo "  ✅ AGENTS.md（通用方法论）"
        fi
    fi
else
    echo "  ⏭ AGENTS.md 已存在，跳过"
fi

# ssot-convention.zh.md
if [ ! -f "$TARGET/ssot-convention.zh.md" ]; then
    cp "$METHODOLOGY_DIR/ssot-convention.zh.md" "$TARGET/ssot-convention.zh.md"
    echo "  ✅ ssot-convention.zh.md"
fi

# README.md（如果没有）
if [ ! -f "$TARGET/README.md" ]; then
    cp "$METHODOLOGY_DIR/README.md" "$TARGET/README.md" 2>/dev/null || true
    echo "  ✅ README.md"
fi

# .gitignore
if [ ! -f "$TARGET/.gitignore" ]; then
    cp "$METHODOLOGY_DIR/.gitignore" "$TARGET/.gitignore" 2>/dev/null || true
    echo "  ✅ .gitignore"
fi

# ─── 步骤 4: 创建目录结构 ─────────────────────
echo -e "${C_GREEN}[4/5] 创建目录结构...${C_NC}"

# 稳定层 docs/
if [ ! -d "$TARGET/docs" ]; then
    mkdir -p "$TARGET/docs"
    for doc in product-overview.md non-functional-reqs.md visual-design.md; do
        [ -f "$METHODOLOGY_DIR/docs/$doc" ] && cp "$METHODOLOGY_DIR/docs/$doc" "$TARGET/docs/$doc" && echo "  ✅ docs/$doc"
    done
fi

# sprint 模板
mkdir -p "$TARGET/docs/sprints"
if [ -d "$METHODOLOGY_DIR/docs/sprints/_template" ] && [ ! -d "$TARGET/docs/sprints/_template" ]; then
    cp -r "$METHODOLOGY_DIR/docs/sprints/_template" "$TARGET/docs/sprints/"
    echo "  ✅ docs/sprints/_template/"
fi
if [ -d "$METHODOLOGY_DIR/docs/sprints/sprint-000_initial" ] && [ ! -d "$TARGET/docs/sprints/sprint-000_initial" ]; then
    cp -r "$METHODOLOGY_DIR/docs/sprints/sprint-000_initial" "$TARGET/docs/sprints/"
    echo "  ✅ docs/sprints/sprint-000_initial/"
fi

# 模块骨架
for dir in apps businesses tools; do
    if [ ! -d "$TARGET/$dir" ]; then
        mkdir -p "$TARGET/$dir/_template/specs"
        [ -f "$METHODOLOGY_DIR/$dir/_template/specs/requirements.md" ] && cp "$METHODOLOGY_DIR/$dir/_template/specs/"* "$TARGET/$dir/_template/specs/" 2>/dev/null || true
        touch "$TARGET/$dir/.gitkeep"
        echo "  ✅ $dir/"
    fi
done

# ADR
if [ ! -d "$TARGET/ADR" ]; then
    mkdir -p "$TARGET/ADR/_template"
    [ -f "$METHODOLOGY_DIR/ADR/_template/ADR.md" ] && cp "$METHODOLOGY_DIR/ADR/_template/ADR.md" "$TARGET/ADR/_template/ADR.md"
    echo "  ✅ ADR/"
fi

# ─── 步骤 5: 生成 AI 约定文件 ────────────────
echo -e "${C_GREEN}[5/5] 生成 AI 约定文件...${C_NC}"

generate_ai_file() {
    local ai=$1
    local source_file="${AI_FILE[$ai]}"
    local target_path
    local content

    if [ -z "$source_file" ]; then
        echo "  ⚠ 未知 AI: $ai，跳过"
        return
    fi

    target_path="$TARGET/$source_file"

    # 如果已有则跳过
    [ -f "$target_path" ] && return

    # 确保父目录存在（trae 等有子目录的）
    mkdir -p "$(dirname "$target_path")"

    # 内容：直接用通用 skill + AI 名称注释
    content=$(cat "$TARGET/AGENTS.md" 2>/dev/null || cat "$TMPDIR/SpecCanon-boot/conventions/ssot-skill.md" 2>/dev/null || true)

    if [ -z "$content" ]; then
        # 最后 fallback
        if curl -fsSL "https://raw.githubusercontent.com/Toketec/SpecCanon-boot/main/conventions/ssot-skill.md" -o "$target_path" 2>/dev/null; then
            echo "  ✅ $source_file (${AI_NAME[$ai]:-$ai})"
        fi
        return
    fi

    # 添加本 AI 的专属注释头
    {
        echo "# $source_file — SSOT ${AI_NAME[$ai]:-$ai} 协作入口"
        echo "#"
        echo "# 从通用方法论语: conventions/ssot-skill.md"
        echo "# 完整规范: ssot-convention.zh.md"
        echo ""
        echo "$content"
    } > "$target_path"

    echo "  ✅ $source_file (${AI_NAME[$ai]:-$ai})"
}

# 获取通用 skill 内容供生成用（如果没有提前下载）
if [ ! -f "$TARGET/AGENTS.md" ]; then
    mkdir -p "$TMPDIR/SpecCanon-boot"
    git clone --depth 1 "$BOOTSTRAP_REPO" "$TMPDIR/SpecCanon-boot" 2>/dev/null || true
fi

if [ "$SELECTED_AI" = "all" ]; then
    # 全生成模式（不偏好某一种）
    for ai in "${ALL_AIS[@]}"; do
        generate_ai_file "$ai"
    done
    echo "  📌 注: 生成了所有 AI 的约定文件，你可删除不需要的。"
else
    # 生成指定 AI 的约定文件，同时保持 AGENTS.md（通用入口）
    generate_ai_file "$SELECTED_AI"
fi

# ─── 替换占位符 ──────────────────────────────
if [[ "$OSTYPE" == "darwin"* ]]; then
    find "$TARGET" -name "*.md" -not -path "*/node_modules/*" -exec sed -i '' "s/{项目名}/$PROJECT_NAME/g" {} \; 2>/dev/null || true
    find "$TARGET" -name "*.md" -not -path "*/node_modules/*" -exec sed -i '' "s/{Project Name}/$PROJECT_NAME/g" {} \; 2>/dev/null || true
else
    find "$TARGET" -name "*.md" -not -path "*/node_modules/*" -exec sed -i "s/{项目名}/$PROJECT_NAME/g" {} \; 2>/dev/null || true
    find "$TARGET" -name "*.md" -not -path "*/node_modules/*" -exec sed -i "s/{Project Name}/$PROJECT_NAME/g" {} \; 2>/dev/null || true
fi

echo ""
echo -e "${C_GREEN}✅ 完成!${C_NC}"
echo -e "${C_CYAN}   目标: $TARGET${C_NC}"
echo ""

# ─── 后续指引 ────────────────────────────────
echo -e "${C_CYAN}下一步:${C_NC}"
echo "  1. cd $TARGET"
echo "  2. 编辑 docs/product-overview.md 写产品概览"
echo "  3. 创建第一个 sprint:"
echo "     cp -r docs/sprints/_template docs/sprints/sprint-001_name"
echo "  4. 创建模块:"
echo "     cp -r apps/_template apps/my-app"
echo "     cp -r businesses/_template businesses/my-service"
echo "  5. 完善 AI 协作:"
echo "     ${AI_FILE[$SELECTED_AI]:-AGENTS.md} 中已包含通用 SSOT 方法论"
echo "     完整规范: cat ssot-convention.zh.md"
echo ""

if [ "$MODE" = "migrate" ]; then
    echo -e "${C_YELLOW}迁移注意:${C_NC}"
    echo "  Phase 0: 骨架就位（✅ 已完成）"
    echo "  Phase 1: 为核心模块写 Retrospec（3 文件，无 plan.md）"
    echo "  Phase 2: 新功能走完整 SSOT 流程"
    echo "  ⚠ 本脚本没有修改你现有的任何代码。"
fi
