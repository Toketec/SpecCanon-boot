#!/bin/bash
# SpecRocket init — 手动初始化新项目（无 AI 工具时使用）
# Usage: ./init.sh 项目名
#
# 自动从 template/ 复制骨架 → git init

set -e

if [ $# -lt 1 ]; then
  echo "用法: $0 项目名"
  exit 1
fi

NAME="$1"
DIR="${2:-$NAME}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMPLATE="$SCRIPT_DIR/template"

if [ ! -d "$TEMPLATE" ]; then
  echo "错误：找不到 template/ 子模块。请确保已执行："
  echo "  git clone --recursive https://github.com/Toketec/SpecRocket.git"
  exit 1
fi

if [ -d "$DIR" ]; then
  echo "错误：目录 '$DIR' 已存在"
  exit 1
fi

echo "→ 创建 $DIR ..."
mkdir -p "$DIR"

echo "→ 复制骨架 ..."
# 使用 . 复制所有内容（包括隐藏文件，排除 .git）
shopt -s dotglob
cp -r "$TEMPLATE"/* "$DIR/"
shopt -u dotglob

cd "$DIR"

echo "→ 初始化 Git ..."
git init
git add .
git commit -m "init: SpecRocket project skeleton"

echo ""
echo "✅ 完成！项目已创建在 $DIR"
echo "下一步建议："
echo "  1. cd $DIR"
echo "  2. 打开 AI 工具，使用 /spec-rocket brainstorm 引导写文档"
echo "     或手动编辑 docs/product-overview.md"
