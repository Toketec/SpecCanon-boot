#!/bin/bash
# SpecRocket init — 手动初始化新项目（无 AI 工具时使用）
# Usage:
#   ./init.sh              # 在当前目录初始化
#   ./init.sh 项目名        # 创建目录并初始化
#
# 自动从 template/ 复制骨架 → git init

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMPLATE="$SCRIPT_DIR/template"

if [ ! -d "$TEMPLATE" ]; then
  echo "错误：找不到 template/ 子模块。请确保已执行："
  echo "  git clone --recursive https://github.com/Toketec/SpecRocket.git"
  exit 1
fi

if [ $# -eq 0 ]; then
  # 无参模式：在当前目录初始化
  TARGET_DIR="."
  echo "→ 在当前目录初始化骨架 ..."
  echo "  路径: $(pwd)"
else
  # 有参模式：创建新目录并初始化
  NAME="$1"
  TARGET_DIR="${2:-$NAME}"
  if [ -d "$TARGET_DIR" ]; then
    echo "错误：目录 '$TARGET_DIR' 已存在"
    exit 1
  fi
  echo "→ 创建 $TARGET_DIR ..."
  mkdir -p "$TARGET_DIR"
fi

echo "→ 复制骨架 ..."
shopt -s dotglob
cp -r "$TEMPLATE"/* "$TARGET_DIR/"
shopt -u dotglob

cd "$TARGET_DIR"

echo "→ 初始化 Git ..."
git init
git add .
git commit -m "init: SpecRocket project skeleton"

echo ""
echo "✅ 完成！项目已初始化"
echo "下一步建议："
echo "  1. 打开 AI 工具，使用 /spec-rocket brainstorm 引导写文档"
echo "     或手动编辑 docs/product-overview.md"
