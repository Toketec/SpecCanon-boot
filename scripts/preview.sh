#!/usr/bin/env bash
# ============================================================================
# spec-rocket preview — 生成项目可视化预览页
# ============================================================================
# 扫描当前 SpecRocket 项目，生成一份 HTML 预览页面：
#   🎯 产品预览 — 一句话定位、用户画像、核心场景
#   🗺️ 业务地图 — 模块清单、Sprint 路线图
#   🏗️ 技术架构 — ADR 决策树、技术栈、数据流
#
# 用法: spec-rocket preview
#   生成 docs/preview.html，在浏览器打开即可
# ============================================================================

set -euo pipefail

G='\033[0;32m'; C='\033[0;36m'; Y='\033[1;33m'; R='\033[0;31m'; N='\033[0m'
ROOT="${1:-$(pwd)}"
OUTPUT="$ROOT/docs/preview.html"

echo -e "${C}╔══════════════════════════════╗${N}"
echo -e "${C}║   spec-rocket preview         ║${N}"
echo -e "${C}╚══════════════════════════════╝${N}"
echo -e "${Y}→ 扫描:${N} $ROOT"

# ─── 提取项目信息 ────────────────────────────

# 项目名
PROJECT_NAME=""
if [ -f "$ROOT/README.md" ]; then
    PROJECT_NAME=$(head -1 "$ROOT/README.md" | sed 's/^# *//;s/{.*}//' | xargs)
fi
[ -z "$PROJECT_NAME" ] && PROJECT_NAME=$(basename "$ROOT")

# 产品概览
PRODUCT_DESC=""; PERSONAS=""; SCENARIOS=""
if [ -f "$ROOT/docs/product-overview.md" ]; then
    # 第一段非空行
    PRODUCT_DESC=$(sed -n '/^[^#]/{p;q}' "$ROOT/docs/product-overview.md" 2>/dev/null | head -1 | xargs)
    # 用户画像部分
    PERSONAS=$(grep -A 10 '## .*用户\|## .*画像\|## .*Persona' "$ROOT/docs/product-overview.md" 2>/dev/null | head -20 || true)
    # 核心场景
    SCENARIOS=$(grep -A 5 '## .*场景\|## .*核心功能' "$ROOT/docs/product-overview.md" 2>/dev/null | head -20 || true)
fi
[ -z "$PRODUCT_DESC" ] && PRODUCT_DESC="（未填写）"

# 模块清单
MODULES=""
for dir in apps businesses tools; do
    if [ -d "$ROOT/$dir" ]; then
        for m in "$ROOT/$dir"/*/; do
            [ -d "$m" ] || continue
            mname=$(basename "$m")
            [ "$mname" = "_template" ] && continue
            MODULES="$MODULES<li><strong>$dir/$mname</strong>"
            # 检查是否有 specs
            [ -f "$m/specs/requirements.md" ] && MODULES="$MODULES <span style='color:#4ade80'>📄 spec</span>"
            MODULES="$MODULES</li>"
        done
    fi
done
[ -z "$MODULES" ] && MODULES="<li style='color:#94a3b8'>（暂无模块，创建业务时自动添加）</li>"

# Sprint 清单
SPRINTS=""
if [ -d "$ROOT/docs/sprints" ]; then
    for s in "$ROOT/docs/sprints"/sprint-*/; do
        [ -d "$s" ] || continue
        sname=$(basename "$s")
        sdesc=$(head -1 "$s/SPRINT-features.md" 2>/dev/null | sed 's/^# *//' || echo "$sname")
        SPRINTS="$SPRINTS<li><strong>$sname</strong> — $sdesc</li>"
    done
fi
[ -z "$SPRINTS" ] && SPRINTS="<li style='color:#94a3b8'>（暂无 sprint）</li>"

# ADR 清单
ADRS=""
if [ -d "$ROOT/ADR" ]; then
    for adr in "$ROOT/ADR"/*.md; do
        [ -f "$adr" ] || continue
        adr_name=$(basename "$adr" .md)
        [ "$adr_name" = "_template" ] && continue
        adr_title=$(head -1 "$adr" | sed 's/^# *//' | xargs)
        [ -z "$adr_title" ] && adr_title="$adr_name"
        ADRS="$ADRS<li><strong>$adr_name</strong> — $adr_title</li>"
    done
fi
[ -z "$ADRS" ] && ADRS="<li style='color:#94a3b8'>（暂无架构记录）</li>"

# 技术栈（从 ADR 和 ssot-convention 中查找）
TECH_STACK=""
if [ -f "$ROOT/ssot-convention.zh.md" ]; then
    TECH_STACK=$(grep '|.*|.*|' "$ROOT/ssot-convention.zh.md" | grep -i '技术\|tech\|前端\|后端\|数据库\|部署' | head -5 || true)
fi
[ -z "$TECH_STACK" ] && TECH_STACK="在项目开发过程中自动记录于 ADR"

# ─── 生成 HTML ──────────────────────────────

cat > "$OUTPUT" <<HTML
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>$PROJECT_NAME — SpecRocket 预览</title>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{background:#0f172a;color:#e2e8f0;font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,sans-serif;padding:40px;line-height:1.6}
.header{text-align:center;padding:40px 0;border-bottom:1px solid #1e293b;margin-bottom:40px}
.header h1{font-size:2rem;background:linear-gradient(135deg,#60a5fa,#a78bfa);-webkit-background-clip:text;-webkit-text-fill-color:transparent}
.header .tagline{color:#94a3b8;margin-top:8px;font-size:0.95rem}
.grid{display:grid;grid-template-columns:1fr 1fr;gap:24px;max-width:1200px;margin:0 auto}
.card{background:#1e293b;border-radius:12px;padding:24px;border:1px solid #334155;transition:border-color 0.2s}
.card:hover{border-color:#4f46e5}
.card.full{grid-column:1/-1}
.card h2{font-size:1.1rem;color:#94a3b8;margin-bottom:16px;display:flex;align-items:center;gap:8px}
.card h2 .icon{font-size:1.3rem}
.card ul{list-style:none}
.card li{padding:8px 0;border-bottom:1px solid #1e293b}
.card li:last-child{border:none}
.card p{color:#cbd5e1}
.empty{color:#475569;font-style:italic}
.badge{display:inline-block;background:#1e1b4b;color:#818cf8;padding:2px 10px;border-radius:999px;font-size:0.75rem;margin-left:8px}
.stats{display:flex;gap:24px;justify-content:center;flex-wrap:wrap;margin-top:24px}
.stat{text-align:center;padding:16px 24px;background:#1e293b;border-radius:8px;min-width:100px}
.stat .num{font-size:1.8rem;font-weight:700;background:linear-gradient(135deg,#60a5fa,#a78bfa);-webkit-background-clip:text;-webkit-text-fill-color:transparent}
.stat .label{color:#94a3b8;font-size:0.85rem;margin-top:4px}
pre{background:#0f172a;padding:12px;border-radius:8px;font-size:0.85rem;overflow-x:auto;color:#a5b4fc;margin-top:8px}
code{background:#334155;padding:1px 6px;border-radius:4px;font-size:0.85rem}
@media(max-width:768px){.grid{grid-template-columns:1fr}body{padding:20px}}
</style>
</head>
<body>

<div class="header">
  <h1>$PROJECT_NAME</h1>
  <p class="tagline">$PRODUCT_DESC</p>
  <div class="stats">
    <div class="stat"><div class="num">$(find "$ROOT/docs" -name "*.md" 2>/dev/null | wc -l)</div><div class="label">文档</div></div>
    <div class="stat"><div class="num">$(find "$ROOT/ADR" -name "*.md" 2>/dev/null | grep -v _template | wc -l)</div><div class="label">ADR</div></div>
    <div class="stat"><div class="num">$(find "$ROOT/apps" "$ROOT/businesses" "$ROOT/tools" -maxdepth 2 -mindepth 2 -type d 2>/dev/null | grep -v _template | wc -l)</div><div class="label">模块</div></div>
    <div class="stat"><div class="num">$(find "$ROOT/docs/sprints" -type d -name "sprint-*" 2>/dev/null | wc -l)</div><div class="label">Sprint</div></div>
  </div>
</div>

<div class="grid">

  <!-- 产品预览 -->
  <div class="card">
    <h2><span class="icon">🎯</span> 产品预览</h2>
    <p>$PRODUCT_DESC</p>
    <h3 style="color:#94a3b8;font-size:0.9rem;margin-top:12px">文档</h3>
    <ul>
      <li><a href="product-overview.md" style="color:#818cf8">product-overview.md</a></li>
      <li><a href="non-functional-reqs.md" style="color:#818cf8">non-functional-reqs.md</a></li>
      <li><a href="visual-design.md" style="color:#818cf8">visual-design.md</a></li>
    </ul>
    <details style="margin-top:12px">
      <summary style="color:#818cf8;cursor:pointer">用户画像</summary>
      <pre>$([ -n "$PERSONAS" ] && echo "$PERSONAS" || echo "（待填写）")</pre>
    </details>
    <details style="margin-top:8px">
      <summary style="color:#818cf8;cursor:pointer">核心场景</summary>
      <pre>$([ -n "$SCENARIOS" ] && echo "$SCENARIOS" || echo "（待填写）")</pre>
    </details>
  </div>

  <!-- 业务地图 -->
  <div class="card">
    <h2><span class="icon">🗺️</span> 业务地图</h2>
    <h3 style="color:#94a3b8;font-size:0.9rem">模块</h3>
    <ul>$MODULES</ul>
    <h3 style="color:#94a3b8;font-size:0.9rem;margin-top:12px">Sprint 路线</h3>
    <ul>$SPRINTS</ul>
  </div>

  <!-- 技术架构 -->
  <div class="card full">
    <h2><span class="icon">🏗️</span> 技术架构</h2>
    <div style="display:grid;grid-template-columns:1fr 1fr;gap:24px">
      <div>
        <h3 style="color:#94a3b8;font-size:0.9rem">ADR 决策记录</h3>
        <ul>$ADRS</ul>
      </div>
      <div>
        <h3 style="color:#94a3b8;font-size:0.9rem">技术栈</h3>
        <p style="color:#cbd5e1;font-size:0.9rem">$TECH_STACK</p>
        <h3 style="color:#94a3b8;font-size:0.9rem;margin-top:12px">目录结构</h3>
        <pre>$(find "$ROOT" -maxdepth 2 -type d -not -path '*/.git*' -not -path '*/node_modules*' | sort | head -20)</pre>
      </div>
    </div>
  </div>

</div>

</body>
</html>
HTML

echo -e "${G}✅ 预览已生成${N}"
echo -e "${C}   $OUTPUT${N}"
echo ""
echo -e "${C}在浏览器打开:${N}"
echo "  open $OUTPUT"
echo "  或手动双击文件打开"
