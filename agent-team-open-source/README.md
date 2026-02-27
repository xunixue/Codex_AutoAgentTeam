# Agent Team Open Source Subrepo

该目录可以单独作为一个 Git 仓库发布给第三方使用。

## 1) 发布者：上传到远端

在 `agent-team-open-source/` 目录执行：

1. `git status --short`
2. `git add .`
3. `git commit -m "chore: prepare open-source bundle"`
4. `git branch -M main`
5. `git remote -v`
6. 若未绑定远端：`git remote add origin <your-remote-url>`
7. 推送：`git push -u origin main`

## 2) 第三者：从克隆开始使用

1. `git clone <repo-url>`
2. `cd <repo-name>`
3. `Copy-Item .env.example .env`
4. 在 `.env` 填入真实 `OPENAI_API_KEY`
5. `powershell -ExecutionPolicy Bypass -File .\scripts\sanitize-secrets.ps1`
6. `rg -n "OPENAI_API_KEY|sk-|ghp_|Bearer\\s+|AKIA|AIza" .\bundle`
7. 查看入口文件：
   - `bundle/agent-orchestrator.yaml`
   - `bundle/feature_list.json`
   - `bundle/progress.autoharness.log`
   - `bundle/progress.md`

## 3) 安全提示

- `.env` 不要提交到 Git。
- 推送前先执行脱敏脚本和敏感信息扫描。
