#!/usr/bin/env bash
# ============================================================================
# SpecCanon Init — 从模板快速创建新项目
# ============================================================================
# 用法: 同 init.sh（本脚本是 init.sh 的内核）
#   不传路径 → 在当前目录创建
#   传路径    → 在指定目录创建
#   传项目名  → 使用指定名称，否则用目录名
# ============================================================================

set -euo pipefail

TEMPLATE_REPO="https://github.com/Toketec/SpecCanon.git"
G='\033[0;32m'; Y='\033[1;33m'; C='\033[0;36m'; R='\033[0;31m'; N='\033[0m'

usage() {
    echo "用法: $0 {new|migrate} [目标路径|项目名] [项目名]"
    exit 1
}

MODE="${1:-}"; [ -z "$MODE" ] && usage
[ "$MODE" != "new" ] && [ "$MODE" != "migrate" ] && usage

if [ -n "${2:-}" ]; then
    if [ -n "${3:-}" ]; then
        TARGET="$2"; PROJECT_NAME="$3"
    else
        if [[ "$2" == *"/"* ]] || [ "$2" = "." ] || [ "$2" = ".." ]; then
            TARGET="$2"
            PROJECT_NAME="$(basename "$(realpath "$TARGET" 2>/dev/null || echo "$TARGET")")"
        else
            TARGET="."; PROJECT_NAME="$2"
        fi
    fi
else
    TARGET="."; PROJECT_NAME="$(basename "$PWD")"
fi

TARGET="$(realpath "$TARGET" 2>/dev/null || echo "$TARGET")"
MODE_LABEL="创建新项目"; [ "$MODE" = migrate ] && MODE_LABEL="迁移现有项目"

echo -e "${C}╔══════════════════════════════╗${N}"
echo -e "${C}║   SpecCanon Init             ║${N}"
echo -e "${C}╚══════════════════════════════╝${N}"
echo -e "${Y}→ 模式:${N} $MODE_LABEL"
echo -e "${Y}→ 目标:${N} $TARGET"
echo -e "${Y}→ 项目:${N} $PROJECT_NAME"
echo ""

# ─── 步骤 1: 获取模板 ────────────────────────
TMPDIR=""; cleanup() { [ -n "$TMPDIR" ] && rm -rf "$TMPDIR" 2>/dev/null || true; }
trap cleanup EXIT

echo -e "${G}[1/3]${N} 获取 SpecCanon 模板..."
METHODOLOGY_DIR=""
for d in "$HOME/SpecCanon" "$(dirname "$0")/../SpecCanon" "$(pwd)/SpecCanon"; do
    [ -f "$d/docs/product-overview.md" ] && { METHODOLOGY_DIR="$d"; break; }
done

if [ -z "$METHODOLOGY_DIR" ]; then
    TMPDIR=$(mktemp -d)
    if ! git clone --depth 1 "$TEMPLATE_REPO" "$TMPDIR/SpecCanon" 2>/dev/null; then
        echo -e "${R}❌ 下载模板失败，检查网络连接${N}"
        exit 1
    fi
    METHODOLOGY_DIR="$TMPDIR/SpecCanon"
fi
echo "  ✅ 模板就绪"

# ─── 步骤 2: 创建项目骨架 ────────────────────
echo -e "${G}[2/3]${N} 创建项目骨架..."
if [ "$MODE" = "new" ]; then
    mkdir -p "$TARGET"
    find "$METHODOLOGY_DIR" -not -path '*/.git/*' -not -name '.git' | while read -r src; do
        [ "$src" = "$METHODOLOGY_DIR" ] && continue
        dst="$TARGET${src#$METHODOLOGY_DIR}"
        if [ -d "$src" ]; then mkdir -p "$dst"
        elif [ ! -f "$dst" ]; then cp "$src" "$dst"; fi
    done
    echo "  ✅ 骨架已创建"
else
    for f in AGENTS.md ssot-convention.zh.md .gitignore; do
        [ -f "$METHODOLOGY_DIR/$f" ] && [ ! -f "$TARGET/$f" ] && cp "$METHODOLOGY_DIR/$f" "$TARGET/$f" && echo "  ✅ $f"
    done
    for d in docs/sprints/_template apps/_template businesses/_template tools/_template ADR/_template; do
        [ -d "$METHODOLOGY_DIR/$d" ] && [ ! -d "$TARGET/$d" ] && mkdir -p "$TARGET/$d" && echo "  ✅ $d/"
    done
fi

# ─── 替换占位符 ──────────────────────────────
echo -e "${G}[3/3]${N} 设置项目名..."
if [[ "$OSTYPE" == darwin* ]]; then
    find "$TARGET" -name "*.md" -not -path "*/node_modules/*" -exec sed -i '' "s/{项目名}/$PROJECT_NAME/g" {} \; 2>/dev/null || true
    find "$TARGET" -name "*.md" -not -path "*/node_modules/*" -exec sed -i '' "s/{Project Name}/$PROJECT_NAME/g" {} \; 2>/dev/null || true
else
    find "$TARGET" -name "*.md" -not -path "*/node_modules/*" -exec sed -i "s/{项目名}/$PROJECT_NAME/g" {} \; 2>/dev/null || true
    find "$TARGET" -name "*.md" -not -path "*/node_modules/*" -exec sed -i "s/{Project Name}/$PROJECT_NAME/g" {} \; 2>/dev/null || true
fi

# ─── Git 初始化 ─────────────────────────────
if [ "$MODE" = "new" ] && [ ! -d "$TARGET/.git" ]; then
    cd "$TARGET"
    git init -b main 2>/dev/null
    git add -A 2>/dev/null
    git commit -m "init: project created from SpecCanon template" --allow-empty 2>/dev/null || true
    cd - >/dev/null
    echo "  ✅ git init + 初始提交"
fi

echo ""
echo -e "${G}✅ 完成!${N}"
echo -e "${C}   目标: $TARGET${N}"
echo ""
echo -e "${C}下一步:${N}"
echo "  1. 编辑 docs/product-overview.md — 写产品概览"
echo "  2. cp -r docs/sprints/_template docs/sprints/sprint-001_name"
echo "  3. cp -r apps/_template apps/my-app"
echo "  4. cat ssot-convention.zh.md — 完整规范"
