# cnb.cool 仓库创建工作流

> 青年力量传播有限公司的代码托管在 https://cnb.cool/youthpower.ltd/

## 认证方式

| 用途 | 凭证 | 示例 |
|:----|:----|:-----|
| git clone/push | `https://cnb:{git_password}@cnb.cool/...` | `git clone https://cnb:4vixQ1175Y1dWHI3CMCf7ElmieE@cnb.cool/youthpower.ltd/all-in-one.git` |
| OpenAPI (v1) | 独立的 API 访问令牌 | `Bearer {api_token}` — 从 cnb.cool 网页 → 个人设置 → 访问令牌创建 |

**注意**：git 密码（HTTP Basic Auth 用）和 API token 是**两种不同的凭证**。git 用的 token 不能调用 `api.cnb.build`。

## 创建新仓库（两种方式）

### 方式 A：网页创建（推荐，不需要 API token）

1. 登录 `https://cnb.cool`
2. 右上角 `+` → 创建仓库
3. 选择组织 `youthpower.ltd`
4. 填写仓库名（如 `all-in-one`）
5. 可见性：Private（公司内部）
6. 点击创建 → 得到一个空仓库
7. 本地推送已有代码：

```bash
cd /path/to/local-project
git remote add origin https://cnb:4vixQ1175Y1dWHI3CMCf7ElmieE@cnb.cool/youthpower.ltd/<repo-name>.git
git push -u origin master
```

### 方式 B：OpenAPI 创建（需要单独的 API token）

```bash
# 创建私有仓库
curl -s -X POST "https://api.cnb.build/youthpower.ltd/repo-slug" \
  -H "accept: application/json" \
  -H "Authorization: Bearer {api_token}" \
  -H "Content-Type: application/json" \
  -d '{"name":"repo-name","description":"...","visibility_level":"Private"}'
```

但实际调用发现 `errcode:5` 或 `errcode:16` 提示未登录，说明 API 认证方式不兼容 git 密码。

## Git 推送注意事项

### 代理问题
系统配置了代理 `192.168.68.200:7890`，推送 HTTPS 可能偶发 `gnutls_handshake` 失败。应对：

```bash
# 只对 cnb.cool 绕过代理（如果全局代理导致失败）
git -c http.version=HTTP/1.1 push origin master

# 或只对 GitHub 绕过（已存记忆）
git -c http.https://github.com.proxy="" push origin main
```

### 首次推送
```bash
git push -u origin master
```

后续只需 `git push`。

## 常用仓库地址

| 仓库 | 地址 |
|:----|:-----|
| all-in-one | `https://cnb.cool/youthpower.ltd/all-in-one.git` |
| swisse-jzt | `https://cnb.cool/youthpower.ltd/swisse-jzt.git`（dev 分支） |
| swisse-admin | `https://cnb.cool/youthpower.ltd/swisse-admin.git`（dev 分支） |
| standard-bootstrap-skill | `https://cnb.cool/youthpower.ltd/standard-bootstrap-skill.git` |
| standard-spec-framework | `https://cnb.cool/youthpower.ltd/standard-spec-framework.git` |
| qlai_v4 | `https://cnb.cool/youthpower.ltd/qlai_v4.git`（main 分支） |
