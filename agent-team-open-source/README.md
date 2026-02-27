# Agent Team Open Source Subrepo

这个目录用于把 Agent Team 能力集成到当前目标仓库中，并可单独作为一个 Git 仓库开源发布。

## 目录结构

- `bundle/`: 最小运行配置与样例数据
- `scripts/sanitize-secrets.ps1`: 发布前脱敏脚本
- `.env.example`: 环境变量模板
- `.gitignore`: 默认忽略 `.env`

## 在目标仓库中使用

1. 复制环境变量模板：
   - `Copy-Item .env.example .env`
2. 按需修改 `bundle/agent-orchestrator.yaml` 中项目信息（`repo`、`defaultBranch` 等）。
3. 脱敏检查：
   - `powershell -ExecutionPolicy Bypass -File .\\scripts\\sanitize-secrets.ps1`
4. 扫描常见敏感串：
   - `rg -n "OPENAI_API_KEY|sk-|ghp_|Bearer\\s+|AKIA|AIza" bundle`

## 作为独立 Git 仓库发布

在 `agent-team-open-source/` 目录下执行：

- `git init`
- `git add .`
- `git commit -m "Initial agent-team open source package"`
- `git branch -M main`
- `git remote add origin <your-remote-url>`
- `git push -u origin main`

## 边界说明

- 默认不包含运行态目录（例如 `.autoharness/`），避免泄露本地状态。
- 只对外分享本目录内容，不要提交 `.env`。
