#!/usr/bin/env bash
# ============================================================================
# spec-canon init — 在当前目录创建空壳项目 + git init
# ============================================================================
# 用法: spec-canon init [项目名]
#   curl -fsSL https://raw.githubusercontent.com/Toketec/SpecRocket/main/spec-canon | bash -s init
# ============================================================================
# 只做三件事：①下载模板 ②复制骨架 ③git init。不写文档、不猜需求。
# ============================================================================

set -euo pipefail

TEMPLATE_REPO="https://github.com/Toketec/SpecRocket-template.git"
G='\033[0;32m'; C='\033[0;36m'; Y='\033[1;33m'; R='\033[0;31m'; N='\033[0m'

TARGET="."
PROJECT_NAME="${1:-$(basename "$PWD")}"
TARGET="$(realpath "$TARGET" 2>/dev/null || echo "$TARGET")"

echo -e "${C}╔══════════════════════════════╗${N}"
echo -e "${C}║   spec-canon init            ║${N}"
echo -e "${C}╚══════════════════════════════╝${N}"
echo -e "${Y}→ 目录:${N} $TARGET"
echo -e "${Y}→ 项目:${N} $PROJECT_NAME"
echo ""

TMPDIR=""; cleanup() { [ -n "$TMPDIR" ] && rm -rf "$TMPDIR" 2>/dev/null || true; }
trap cleanup EXIT

# 1. 获取模板
echo -e "${G}[1/3]${N} 获取 SpecRocket 模板..."
METHODOLOGY_DIR=""
for d in "$HOME/SpecRocket" "$(dirname "$0")/../SpecRocket" "$(pwd)/SpecRocket"; do
    [ -f "$d/docs/product-overview.md" ] && { METHODOLOGY_DIR="$d"; break; }
done
if [ -z "$METHODOLOGY_DIR" ]; then
    TMPDIR=$(mktemp -d)
    if ! git clone --depth 1 "$TEMPLATE_REPO" "$TMPDIR/SpecRocket" 2>/dev/null; then
        echo -e "${R}❌ 下载模板失败，检查网络${N}"; exit 1
    fi
    METHODOLOGY_DIR="$TMPDIR/SpecRocket"
fi
echo "  ✅ 模板就绪"

# 2. 复制骨架（空壳，不写任何业务内容）
echo -e "${G}[2/3]${N} 创建空壳项目..."
mkdir -p "$TARGET"
find "$METHODOLOGY_DIR" -not -path '*/.git/*' -not -name '.git' | while read -r src; do
    [ "$src" = "$METHODOLOGY_DIR" ] && continue
    dst="$TARGET${src#$METHODOLOGY_DIR}"
    if [ -d "$src" ]; then mkdir -p "$dst"
    elif [ ! -f "$dst" ]; then cp "$src" "$dst"; fi
done
# 替换占位符
if [[ "$OSTYPE" == darwin* ]]; then
    find "$TARGET" -name "*.md" -not -path "*/node_modules/*" -exec sed -i '' "s/{项目名}/$PROJECT_NAME/g" {} \; 2>/dev/null || true
    find "$TARGET" -name "*.md" -not -path "*/node_modules/*" -exec sed -i '' "s/{Project Name}/$PROJECT_NAME/g" {} \; 2>/dev/null || true
else
    find "$TARGET" -name "*.md" -not -path "*/node_modules/*" -exec sed -i "s/{项目名}/$PROJECT_NAME/g" {} \; 2>/dev/null || true
    find "$TARGET" -name "*.md" -not -path "*/node_modules/*" -exec sed -i "s/{Project Name}/$PROJECT_NAME/g" {} \; 2>/dev/null || true
fi
echo "  ✅ 空壳已创建"

# 3. Git 初始化
echo -e "${G}[3/3]${N} git init..."
cd "$TARGET"
git init -b main 2>/dev/null
git add -A 2>/dev/null
git commit -m "init: project created from SpecRocket template" --allow-empty 2>/dev/null || true
cd - >/dev/null
echo "  ✅ git init + 初始提交"

echo ""
echo -e "${G}✅ 空壳就绪${N}"
echo -e "${C}   $TARGET${N}"
echo ""
echo -e "${C}下一步:${N}"
echo "  编辑 docs/product-overview.md 开始写产品"
echo "  或运行 spec-canon preview 看看项目结构"
