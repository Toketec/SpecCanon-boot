#!/usr/bin/env bash
# ============================================================================
# spec-canon brainstorm — AI 思维导引：帮你填产品文档
# ============================================================================
# 用法: spec-canon brainstorm
#
# 效果:
#   1. 检查当前目录是否是 SpecCanon 项目
#   2. 引导你回答几个关键问题
#   3. 生成 docs/product-overview.md + 第一个 sprint
# ============================================================================

set -euo pipefail

G='\033[0;32m'; C='\033[0;36m'; Y='\033[1;33m'; R='\033[0;31m'; N='\033[0m'
ROOT="${1:-$(pwd)}"

echo -e "${C}╔══════════════════════════════╗${N}"
echo -e "${C}║   spec-canon brainstorm      ║${N}"
echo -e "${C}╚══════════════════════════════╝${N}"
echo ""

# ─── 检查项目是否已初始化 ────────────────────
if [ ! -f "$ROOT/docs/product-overview.md" ]; then
    echo -e "${Y}⚠ 当前目录不是 SpecCanon 项目。先运行:${N}"
    echo "  spec-canon init"
    echo "  或 curl ... | bash -s init"
    exit 1
fi

# ─── 检查是否已有内容 ────────────────────────
HAS_CONTENT=$(grep -v '^{.*}$' "$ROOT/docs/product-overview.md" 2>/dev/null | grep -c '[a-zA-Z0-9]' || true)
if [ "$HAS_CONTENT" -gt 5 ]; then
    echo -e "${Y}⚠ product-overview.md 已有内容。重新 brainstorm 会覆盖。${N}"
    read -p "  继续？(y/N) " confirm
    [ "$confirm" != "y" ] && [ "$confirm" != "Y" ] && echo "  取消" && exit 0
fi

# ─── 交互问答 ────────────────────────────────
echo -e "${C}我来引导你想清楚这个项目做什么。${N}"
echo -e "${C}每回答一个问题，我就记录到产品文档中。${N}"
echo ""

ask() {
    local num=$1; shift
    local question=$1; shift
    local default="${1:-}"
    local answer=""
    while [ -z "$answer" ]; do
        echo -e "${Y}Q${num}:${N} $question"
        [ -n "$default" ] && echo -e "  ${C}(默认: $default)${N}"
        read -p "  → " answer
        [ -z "$answer" ] && [ -n "$default" ] && answer="$default"
    done
    echo "$answer"
}

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ONELINER=$(ask 1 "一句话描述这个产品做什么？")
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
AUDIENCE=$(ask 2 "目标用户是谁？（例如：学校家长、摄影师、运营人员）")
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
SCENE=$(ask 3 "用户最核心的场景是什么？（一句话描述用户做什么）")
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
TERM=$(ask 4 "项目涉及哪些关键术语？（逗号分隔，如：SKU、订单、班级）")
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
FEATURE=$(ask 5 "第一个版本你最想做的功能是什么？")
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# ─── 生成产品文档 ────────────────────────────
echo ""
echo -e "${G}[1/2]${N} 写入产品文档..."

cat > "$ROOT/docs/product-overview.md" << EOF
# $ONELINER

> $SCENE

---

## 用户画像

| 角色 | 描述 |
|:----|:-----|
| $(echo "$AUDIENCE" | sed 's/、/\|/;s/，/\|/') | 核心用户 |
| 其他 | 待补充 |

## 核心场景

### 场景一：$SCENE

1. 用户进入系统
2. 完成核心操作
3. 获得预期结果

## 业务术语表

| 术语 | 解释 |
|:----|:-----|
$(echo "$TERM" | tr ',' '\n' | while read t; do
  [ -n "$t" ] && echo "| $t | 待补充 |"
done)

## 一句话定位

$ONELINER

---

> 本文档由 \`spec-canon brainstorm\` 生成，请根据实际情况完善。
EOF

echo "  ✅ docs/product-overview.md"

# ─── 生成第一个 sprint ──────────────────────
echo -e "${G}[2/2]${N} 创建第一个 sprint..."

# 找下一个 sprint 编号
NEXT_NUM=1
for d in "$ROOT/docs/sprints"/sprint-*/; do
    [ -d "$d" ] || continue
    NUM=$(echo "$d" | grep -oP 'sprint-\K[0-9]+' || echo "0")
    [ "$NUM" -ge "$NEXT_NUM" ] && NEXT_NUM=$((NUM + 1))
done

SPRINT_DIR="$ROOT/docs/sprints/sprint-$(printf '%03d' $NEXT_NUM)_$(echo "$FEATURE" | tr ' ' '_' | tr -cd 'a-zA-Z0-9_\-')"

# 从模板复制
if [ -d "$ROOT/docs/sprints/_template" ]; then
    cp -r "$ROOT/docs/sprints/_template" "$SPRINT_DIR"
    echo "  ✅ 已创建: docs/sprints/$(basename $SPRINT_DIR)/"

    # 填写 SPRINT-features.md
    SPRINT_FILE="$SPRINT_DIR/SPRINT-features.md"
    if [ -f "$SPRINT_FILE" ]; then
        cat > "$SPRINT_FILE" << EOF
# $(basename $SPRINT_DIR) — $FEATURE

## 冲刺目标

$FEATURE

## 功能清单

| 编号 | 功能 | 优先级 | 状态 |
|:----:|:----|:-----:|:----:|
| F1 | $FEATURE | P0 | ☐ |

## 验收条件

- [ ] $FEATURE 可正常工作

> 本文档由 \`spec-canon brainstorm\` 生成，请根据实际情况完善。
EOF
    fi
else
    echo -e "${Y}  ⚠ _template 不存在，跳过 sprint 创建${N}"
fi

echo ""
echo -e "${G}✅ brainstorm 完成${N}"
echo ""
echo -e "${C}生成了什么:${N}"
echo "  📄 docs/product-overview.md  — 产品概览"
echo "  📁 docs/sprints/$(basename $SPRINT_DIR)/  — 第一个 sprint"
echo ""
echo -e "${C}接下来:${N}"
echo "  1. 编辑 product-overview.md 完善细节"
echo "  2. 编辑 sprint 文档补充功能清单"
echo "  3. 进入 Step 2: 把 sprint 拖到新 AI 对话中 → 引导 AI 写 specs"
echo ""
echo -e "${Y}需要修改？直接编辑对应 md 文件即可，brainstorm 可以反复跑。${N}"
