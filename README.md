# Agent Team Open Source Bundle

这个目录是可直接发布给他人的 Agent Team 开源包，目标是：
- 清理敏感信息（尤其是 API key / token）
- 让别人拿到后能快速配置并推送到自己的 Git 仓库

## 目录说明

- `bundle/`: 对外共享的核心文件（编排配置、feature 列表、进度日志等）
- `scripts/sanitize-secrets.ps1`: 发布前脱敏脚本
- `.env.example`: 环境变量模板（不含真实密钥）
- `.gitignore`: 默认忽略 `.env`

## 一分钟使用流程

1. 进入此目录：
   - `cd agent-team-open-source`
2. 拷贝环境变量模板：
   - `Copy-Item .env.example .env`
3. 在 `.env` 中填写真实值（不要提交到 Git）：
   - `OPENAI_API_KEY=<your_real_key>`
4. 运行脱敏脚本（会清理 `bundle/` 内疑似密钥）：
   - `powershell -ExecutionPolicy Bypass -File .\scripts\sanitize-secrets.ps1`
5. 初始化并推送到你的远端仓库：
   - `git init`
   - `git add .`
   - `git commit -m "Initial open-source agent team bundle"`
   - `git remote add origin <your-remote-url>`
   - `git push -u origin master`

## 关键入口文件

- `bundle/agent-orchestrator.yaml`
- `bundle/feature_list.json`
- `bundle/progress.autoharness.log`
- `bundle/progress.md`

## 发布前检查（建议）

- 脱敏后检查是否仍含敏感串：
  - `rg -n "OPENAI_API_KEY|sk-|ghp_|Bearer\\s+" bundle`
- 检查清单文件：
  - `Get-Content .\bundle\MANIFEST.txt`

## 注意事项

- 如果此目录已经绑定了旧远端，先移除：
  - `git remote remove origin`
- 只分享 `agent-team-open-source/` 目录，不要把你的本地 `.env` 或个人缓存文件上传。
