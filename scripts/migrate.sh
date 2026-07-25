#!/usr/bin/env bash
# ============================================================================
# spec-rocket migrate — 在当前项目嵌入 SpecRocket 骨架
# ============================================================================
# 不修改现有代码，只添加规范文件（AGENTS.md、目录模板）。
# ============================================================================

set -euo pipefail

TEMPLATE_REPO="https://github.com/Toketec/SpecRocket-template.git"
G='\033[0;32m'; C='\033[0;36m'; Y='\033[1;33m'; R='\033[0;31m'; N='\033[0m'

TARGET="$(pwd)"
PROJECT_NAME="${1:-$(basename "$TARGET")}"

echo -e "${C}╔══════════════════════════════╗${N}"
echo -e "${C}║   spec-rocket migrate         ║${N}"
echo -e "${C}╚══════════════════════════════╝${N}"
echo -e "${Y}→ 目标:${N} $TARGET"
echo ""

TMPDIR=""; cleanup() { [ -n "$TMPDIR" ] && rm -rf "$TMPDIR" 2>/dev/null || true; }
trap cleanup EXIT

# 获取模板
echo -e "${G}[1/2]${N} 获取模板..."
METHODOLOGY_DIR=""
for d in "$HOME/SpecRocket" "$(dirname "$0")/../SpecRocket" "$(pwd)/SpecRocket"; do
    [ -f "$d/docs/product-overview.md" ] && { METHODOLOGY_DIR="$d"; break; }
done
if [ -z "$METHODOLOGY_DIR" ]; then
    TMPDIR=$(mktemp -d)
    if ! git clone --depth 1 "$TEMPLATE_REPO" "$TMPDIR/SpecRocket" 2>/dev/null; then
        echo -e "${R}❌ 下载模板失败${N}"; exit 1
    fi
    METHODOLOGY_DIR="$TMPDIR/SpecRocket"
fi

# 嵌入骨架（只添加不存在的文件）
echo -e "${G}[2/2]${N} 嵌入骨架..."
for f in AGENTS.md ssot-convention.zh.md .gitignore; do
    [ -f "$METHODOLOGY_DIR/$f" ] && [ ! -f "$TARGET/$f" ] && cp "$METHODOLOGY_DIR/$f" "$TARGET/$f" && echo "  ✅ $f"
done
for d in docs/sprints/_template apps/_template businesses/_template tools/_template ADR/_template; do
    [ -d "$METHODOLOGY_DIR/$d" ] && [ ! -d "$TARGET/$d" ] && mkdir -p "$TARGET/$d" && echo "  ✅ $d/"
done

echo ""
echo -e "${G}✅ 骨架已嵌入${N}"
echo -e "${Y}⚠ 未修改你现有代码${N}"
