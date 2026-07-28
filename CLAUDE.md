# SpecRocket — AI 协作规范

> 用于 Claude Code / Cursor / Windsurf / Cline 等 AI 编码代理。
> 同步自 SKILL.md，保持一致。

## 斜杠命令

| 命令 | 用途 |
|:----|:------|
| `init [项目名]` | 从 template/ 子模块复制骨架。**无参=当前目录，有参=新建项目目录** |
| `brainstorm` | 引导用户描述产品 → 自动生成产品文档 + 创建 sprint |
| `migrate` | 给现有项目嵌入骨架文件 |
| `preview` | 扫描项目 → 生成 dark-theme 可视化预览页 |

## `/spec-rocket init` — 建新项目

**做什么：** 从 `template/` submodule 复制 SpecRocket 骨架到目标项目，初始化 Git。
**无参时在当前目录初始化，有参时创建项目目录。**

**手动执行（无 AI 时）：**
```bash
./init.sh              # 在当前目录初始化
./init.sh 项目名        # 创建目录并初始化
```

**AI 斜杠命令执行时：**
1. **判断目标：**
   - 无参数 → 在当前目录 `.` 进行初始化
   - 有参数 `项目名` → 创建目录 `项目名` 并进入
2. **获取模板：** 如果当前不在 SpecRocket 仓库内，先 `git clone --recursive https://github.com/Toketec/SpecRocket.git` 到临时目录，获取 `template/` 内容
3. 复制 `template/` 全部内容到目标目录
4. 执行 `git init` + 首次提交
5. 判断：
   - 用户需求清晰 → 继续写 `docs/product-overview.md` + 第一个 sprint
   - 需求不清晰 → 告诉用户完成，建议下一步跑 `/spec-rocket brainstorm`

---

## 其他命令（概要）

| 命令 | 说明 |
|:----|:------|
| `/spec-rocket brainstorm` | 5 问引导 → 生成产品文档 + sprint |
| `/spec-rocket migrate` | 给现有项目嵌入骨架（不碰代码） |
| `/spec-rocket preview` | 生成 dark-theme 可视化预览页 → `docs/preview.html` |
