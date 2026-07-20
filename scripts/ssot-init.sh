#!/usr/bin/env bash
# ============================================================================
# SSOT Init — SSOT 项目自包含引导脚本
# ============================================================================
# 本脚本不依赖任何本地路径，自动从 GitHub 获取最新模板。
# 用法:
#   ssot-init.sh new <目标路径> [项目名称]
#   ssot-init.sh migrate <目标路径> [项目名称]
#
# 示例:
#   ssot-init.sh new ../my-app "我的应用"
#   ssot-init.sh migrate ../legacy-project
# ============================================================================

set -euo pipefail

SSOT_REPO="https://github.com/Toketec/ssot-methodology.git"
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[1;33m'
COLOR_CYAN='\033[0;36m'
COLOR_RED='\033[0;31m'
COLOR_NC='\033[0m'

echo -e "${COLOR_CYAN}╔══════════════════════════════════════╗${COLOR_NC}"
echo -e "${COLOR_CYAN}║   SSOT Init v1.0                    ║${COLOR_NC}"
echo -e "${COLOR_CYAN}╚══════════════════════════════════════╝${COLOR_NC}"
echo ""

# ─── 参数解析 ───────────────────────────────────────
usage() {
    echo "用法: $0 {new|migrate} <目标路径> [项目名称]"
    echo ""
    echo "  new       — 创建全新 SSOT 项目"
    echo "  migrate   — 在现有项目中嵌入 SSOT 骨架"
    echo ""
    echo "示例:"
    echo "  $0 new  ../my-app \"我的应用\""
    echo "  $0 migrate ../legacy-project \"遗留项目\""
    exit 1
}

if [ $# -lt 2 ]; then
    usage
fi

MODE="$1"
TARGET="$(realpath "$2" 2>/dev/null || echo "$2")"
PROJECT_NAME="${3:-$(basename "$TARGET")}"

MODE_LABEL="创建新项目"
[ "$MODE" = "migrate" ] && MODE_LABEL="迁移现有项目"

echo -e "${COLOR_YELLOW}→ 模式:${COLOR_NC} $MODE_LABEL"
echo -e "${COLOR_YELLOW}→ 目标:${COLOR_NC} $TARGET"
echo -e "${COLOR_YELLOW}→ 项目:${COLOR_NC} $PROJECT_NAME"
echo ""

# ─── 获取模板 ───────────────────────────────────────
TMPDIR=""
cleanup() {
    [ -n "$TMPDIR" ] && rm -rf "$TMPDIR" 2>/dev/null || true
}
trap cleanup EXIT

echo -e "${COLOR_GREEN}[1/5]${COLOR_NC} 获取 SSOT 方法论模板..."

# 检查是否有本地方法论仓库（更快）
LOCAL_METHODOLOGY=""
for candidate in \
    "$HOME/ssot-methodology" \
    "$(dirname "$0")/../ssot-methodology" \
    "$(pwd)/ssot-methodology"; do
    if [ -f "$candidate/scripts/bootstrap-project.sh" ]; then
        LOCAL_METHODOLOGY="$candidate"
        echo "  找到本地模板: $LOCAL_METHODOLOGY"
        break
    fi
done

METHODOLOGY_DIR=""
if [ -n "$LOCAL_METHODOLOGY" ]; then
    METHODOLOGY_DIR="$LOCAL_METHODOLOGY"
else
    # 从 GitHub 克隆
    TMPDIR="$(mktemp -d)"
    echo "  从 GitHub 下载模板..."
    if git clone --depth 1 "$SSOT_REPO" "$TMPDIR/ssot-methodology" 2>/dev/null; then
        METHODOLOGY_DIR="$TMPDIR/ssot-methodology"
        echo "  ✅ 下载完成"
    else
        echo -e "${COLOR_RED}  ❌ 从 GitHub 克隆失败。检查网络连接。${COLOR_NC}"
        echo "  你也可以先手动克隆:"
        echo "    git clone $SSOT_REPO"
        echo "  然后把脚本放在同目录再试。"
        exit 1
    fi
fi

# ─── 目标准备 ───────────────────────────────────────
echo -e "${COLOR_GREEN}[2/5]${COLOR_NC} 准备目标目录..."
if [ "$MODE" = "new" ]; then
    mkdir -p "$TARGET"
    echo "  目录已创建: $TARGET"
else
    if [ ! -d "$TARGET" ]; then
        echo -e "${COLOR_RED}  ❌ 目标目录不存在: $TARGET${COLOR_NC}"
        exit 1
    fi
    echo "  目标已存在: $TARGET"
fi

# ─── 复制核心骨架 ──────────────────────────────────
echo -e "${COLOR_GREEN}[3/5]${COLOR_NC} 复制核心文件..."

# AGENTS.md
if [ ! -f "$TARGET/AGENTS.md" ]; then
    cp "$METHODOLOGY_DIR/AGENTS.md" "$TARGET/AGENTS.md"
    echo "  ✅ AGENTS.md"
else
    echo "  ⏭️  AGENTS.md 已存在，跳过"
fi

# ssot-convention.zh.md
if [ ! -f "$TARGET/ssot-convention.zh.md" ]; then
    cp "$METHODOLOGY_DIR/ssot-convention.zh.md" "$TARGET/ssot-convention.zh.md"
    echo "  ✅ ssot-convention.zh.md"
else
    echo "  ⏭️  ssot-convention.zh.md 已存在，跳过"
fi

# .gitignore
if [ ! -f "$TARGET/.gitignore" ]; then
    cp "$METHODOLOGY_DIR/.gitignore" "$TARGET/.gitignore" 2>/dev/null || true
    echo "  ✅ .gitignore"
else
    echo "  ⏭️  .gitignore 已存在，跳过"
fi

# ─── 创建目录结构 ──────────────────────────────────
echo -e "${COLOR_GREEN}[4/5]${COLOR_NC} 创建目录结构..."

# 稳定层 docs/
if [ ! -d "$TARGET/docs" ]; then
    mkdir -p "$TARGET/docs"
    # 复制稳定层文档（只在全新创建时复制）
    for doc in product-overview.md non-functional-reqs.md visual-design.md; do
        if [ -f "$METHODOLOGY_DIR/docs/$doc" ]; then
            cp "$METHODOLOGY_DIR/docs/$doc" "$TARGET/docs/$doc"
            echo "  ✅ docs/$doc"
        fi
    done
else
    # 迁移模式：只复制不存在的稳定层文档
    for doc in product-overview.md non-functional-reqs.md visual-design.md; do
        if [ -f "$METHODOLOGY_DIR/docs/$doc" ] && [ ! -f "$TARGET/docs/$doc" ]; then
            cp "$METHODOLOGY_DIR/docs/$doc" "$TARGET/docs/$doc"
            echo "  ✅ docs/$doc (新增)"
        fi
    done
fi

# sprint 模板
mkdir -p "$TARGET/docs/sprints"
if [ -d "$METHODOLOGY_DIR/docs/sprints/_template" ]; then
    if [ ! -d "$TARGET/docs/sprints/_template" ]; then
        cp -r "$METHODOLOGY_DIR/docs/sprints/_template" "$TARGET/docs/sprints/"
        echo "  ✅ docs/sprints/_template/"
    else
        echo "  ⏭️  docs/sprints/_template/ 已存在，跳过"
    fi
fi
if [ -d "$METHODOLOGY_DIR/docs/sprints/sprint-000_initial" ]; then
    if [ ! -d "$TARGET/docs/sprints/sprint-000_initial" ]; then
        cp -r "$METHODOLOGY_DIR/docs/sprints/sprint-000_initial" "$TARGET/docs/sprints/"
        echo "  ✅ docs/sprints/sprint-000_initial/"
    else
        echo "  ⏭️  docs/sprints/sprint-000_initial/ 已存在，跳过"
    fi
fi

# 模块骨架
for dir in apps businesses tools; do
    if [ ! -d "$TARGET/$dir" ]; then
        mkdir -p "$TARGET/$dir/_template/specs"
        # 复制 spec 模板
        if [ -f "$METHODOLOGY_DIR/$dir/_template/specs/requirements.md" ]; then
            cp "$METHODOLOGY_DIR/$dir/_template/specs/"* "$TARGET/$dir/_template/specs/" 2>/dev/null || true
        fi
        touch "$TARGET/$dir/.gitkeep"
        echo "  ✅ $dir/"
    else
        # 迁移模式：只创建 _template（如果不存在）
        if [ ! -d "$TARGET/$dir/_template" ]; then
            mkdir -p "$TARGET/$dir/_template/specs"
            if [ -f "$METHODOLOGY_DIR/$dir/_template/specs/requirements.md" ]; then
                cp "$METHODOLOGY_DIR/$dir/_template/specs/"* "$TARGET/$dir/_template/specs/" 2>/dev/null || true
            fi
            echo "  ✅ $dir/_template/ (新增)"
        else
            echo "  ⏭️  $dir/_template/ 已存在，跳过"
        fi
    fi
done

# ADR 模板
if [ ! -d "$TARGET/ADR" ]; then
    mkdir -p "$TARGET/ADR/_template"
    if [ -f "$METHODOLOGY_DIR/ADR/_template/ADR.md" ]; then
        cp "$METHODOLOGY_DIR/ADR/_template/ADR.md" "$TARGET/ADR/_template/ADR.md"
    fi
    echo "  ✅ ADR/"
fi

# ─── 替换占位符 ──────────────────────────────────
echo -e "${COLOR_GREEN}[5/5]${COLOR_NC} 写入项目名..."

if [[ "$OSTYPE" == "darwin"* ]]; then
    find "$TARGET" -name "*.md" -not -path "*/node_modules/*" -exec sed -i '' "s/{项目名}/$PROJECT_NAME/g" {} \; 2>/dev/null || true
    find "$TARGET" -name "*.md" -not -path "*/node_modules/*" -exec sed -i '' "s/{Project Name}/$PROJECT_NAME/g" {} \; 2>/dev/null || true
else
    find "$TARGET" -name "*.md" -not -path "*/node_modules/*" -exec sed -i "s/{项目名}/$PROJECT_NAME/g" {} \; 2>/dev/null || true
    find "$TARGET" -name "*.md" -not -path "*/node_modules/*" -exec sed -i "s/{Project Name}/$PROJECT_NAME/g" {} \; 2>/dev/null || true
fi

echo ""
echo -e "${COLOR_GREEN}✅ 完成!${COLOR_NC} $MODE_LABEL"
echo -e "${COLOR_CYAN}   目标: $TARGET${COLOR_NC}"
echo ""

# ─── 后续指引 ──────────────────────────────────
if [ "$MODE" = "new" ]; then
    echo -e "${COLOR_CYAN}下一步:${COLOR_NC}"
    echo "  1. cd $TARGET"
    echo "  2. 编辑 docs/product-overview.md 写产品概览"
    echo "  3. 创建第一个 sprint:"
    echo "     cp -r docs/sprints/_template docs/sprints/sprint-001_name"
    echo "  4. 创建后端服务:"
    echo "     cp -r businesses/_template businesses/my-service"
    echo "  5. 完整规范: cat ssot-convention.zh.md"
    echo ""
    echo -e "${COLOR_CYAN}让 AI 协作:${COLOR_NC}"
    echo "  把 AGENTS.md 给 AI 读，它会知道如何遵循五步流程。"
fi

if [ "$MODE" = "migrate" ]; then
    echo -e "${COLOR_CYAN}迁移四阶段:${COLOR_NC}"
    echo "  Phase 0: 骨架就位（✅ 已完成）"
    echo "  Phase 1: 为最核心的模块写 Retrospec"
    echo "    在 apps/{module}/specs/ 或 businesses/{module}/specs/ 中"
    echo "    写 requirements + tasks + check（不写 plan.md）"
    echo "  Phase 2: 新功能强制走完整 SSOT 流程"
    echo "  Phase 3: 每次 sprint 选 1 个模块补 Retrospec"
    echo ""
    echo -e "${COLOR_YELLOW}注意:${COLOR_NC} 迁移没有修改你现有的任何代码。只添加了 SSOT 骨架文件。"
fi
