# GitHub 一键部署脚本
# 使用方法：在 PowerShell 中运行 ./deploy.ps1

Write-Host "=== 开始部署到 GitHub ===" -ForegroundColor Green

# 1. 清理并重新构建
Write-Host "1/4 正在构建网站..." -ForegroundColor Yellow
Set-Location "D:/Aproject2/ai_workspace/myblog"
hugo --gc --minify 2>&1 | Out-Null
Write-Host "   ✓ 构建完成" -ForegroundColor Green

# 2. 将 public 目录内容添加到 git
Write-Host "2/4 正在准备文件..." -ForegroundColor Yellow
cd public
# 确保 git 可以追踪 public 目录
git add -A
cd ..
git add public/
Write-Host "   ✓ 文件已准备" -ForegroundColor Green

# 3. 提交并推送
Write-Host "3/4 正在提交..." -ForegroundColor Yellow
git commit -m "deploy: hugo site built locally with Hugo v0.158.0" 2>&1 | Out-Null
Write-Host "   ✓ 提交完成" -ForegroundColor Green

Write-Host "4/4 正在推送到 GitHub..." -ForegroundColor Yellow
git push origin main 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "   ✓ 推送完成！" -ForegroundColor Green
    Write-Host "`n=== 部署成功！" -ForegroundColor Cyan
    Write-Host "请在 1-2 分钟后访问 https://smile-1973.github.io/" -ForegroundColor White
} else {
    Write-Host "   ✗ 推送失败，请检查网络连接或认证" -ForegroundColor Red
    Write-Host "如果提示认证错误，请运行：git remote set-url origin https://<你的 GitHub 用户名>:<PAT>@github.com/smile-1973/smile-1973.github.io.git" -ForegroundColor Yellow
}
