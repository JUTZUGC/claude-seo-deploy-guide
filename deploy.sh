#!/usr/bin/env bash
set -euo pipefail
# Claude SEO 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/AgriciDaniel/claude-seo#install
# 更新日期：2026-10-26
# 类型：script
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v git >/dev/null 2>&1 || { echo "需要先安装 Git"; exit 1; }
command -v node >/dev/null 2>&1 || { echo "需要先安装 Node.js"; exit 1; }

mkdir -p .download
cd .download

npx -y skills@latest add https://github.com/AgriciDaniel/claude-seo --skill seo -g -a trae trae-cn -y --copy
npx -y skills@latest list -g

echo ""

echo "安装完成：重启客户端，在对话里说「对这个网站做一次完整 SEO 审计」；要完整插件请在 Claude Code 里用 /plugin 安装"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/AgriciDaniel/claude-seo#install"
