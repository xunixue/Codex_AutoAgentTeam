# Codex_AutoAgentTeam

本仓库内的 `agent-team-open-source/` 是可独立开源分发的 Agent Team 包。

## 1) 维护者：直接上传到本仓库远端

在仓库根目录执行（`D:\AgentTeamTools\Codex_AutoAgentTeam`）：

1. 检查当前分支和远端
   - `git branch --show-current`
   - `git remote -v`
2. 提交本地改动
   - `git add .`
   - `git commit -m "docs: add publish + third-party usage steps"`
3. 推送到当前仓库远端（推荐）
   - `git push origin HEAD`
4. 如果是首次推送当前分支，使用
   - `git push -u origin HEAD`

## 2) 第三者：下载仓库后如何使用

1. 克隆仓库
   - `git clone https://github.com/xunixue/Codex_AutoAgentTeam.git`
2. 进入开源包目录
   - `cd Codex_AutoAgentTeam\agent-team-open-source`
3. 复制环境变量模板
   - `Copy-Item .env.example .env`
4. 编辑 `.env`，填入真实密钥
   - `OPENAI_API_KEY=<your_real_key>`
5. 运行脱敏脚本（防止误带密钥）
   - `powershell -ExecutionPolicy Bypass -File .\scripts\sanitize-secrets.ps1`
6. 做一次快速自检
   - `rg -n "OPENAI_API_KEY|sk-|ghp_|Bearer\\s+|AKIA|AIza" .\bundle`
   - `Get-Content .\bundle\MANIFEST.txt`
7. 查看并按需修改核心配置
   - `bundle\agent-orchestrator.yaml`
   - `bundle\feature_list.json`
   - `bundle\progress.autoharness.log`
   - `bundle\progress.md`
8. 将该目录作为独立开源仓库发布（可选）
   - `git init`
   - `git add .`
   - `git commit -m "Initial agent-team open-source package"`
   - `git branch -M main`
   - `git remote add origin <your-repo-url>`
   - `git push -u origin main`

## 3) 注意事项

- `.env` 只本地使用，不要提交。
- 如果 `origin` 已存在，先执行 `git remote remove origin` 再重新绑定。
