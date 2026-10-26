# Claude SEO 一键安装指南

> 第三方部署指南 · 非 Claude SEO 官方仓库。官方项目：[AgriciDaniel/claude-seo](https://github.com/AgriciDaniel/claude-seo)
> 内容来自官方文档（2026-10-26）。项目迭代快，请以[官方文档](https://github.com/AgriciDaniel/claude-seo#install)为准。

[![⚡ 一键安装](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键安装推荐用百度搭子)

## 一键安装（推荐：用百度搭子）

> [!TIP]
> 不用自己拷文件，让百度搭子把 SEO 技能装好，之后给个网址就能开始审计。

⚠️ 这是 Claude Code 插件：本指南用 Skills CLI 把 seo 技能装到 Trae / Trae CN 的全局目录。完整插件（26 子技能 + 19 代理 + /seo 命令）需要在 Claude Code 里用 /plugin 安装，其它客户端只拿到技能部分。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/claude-seo-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会用 Skills CLI 把 seo 技能装到 Trae / Trae CN 的全局目录，再列一次已安装技能确认，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Git；构建依赖以官方文档为准。）



## Claude SEO 是什么？

Claude SEO 是开源的给 Claude Code 用的 SEO 审计插件（26 子技能 + 19 代理）（协议：MIT，<img src="https://img.shields.io/github/stars/AgriciDaniel/claude-seo?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

给一个网址做完整 SEO 审计：技术 SEO、内容与 E-E-A-T、Schema、AI 搜索（GEO）、本地与电商、国际 SEO；输出按影响排序的行动清单，并说明为什么重要、怎么验证。

- 覆盖面：技术 SEO、Core Web Vitals、E-E-A-T、Schema、GEO、本地 / 电商 / 国际
- 组成：26 个子技能 + 19 个专职 Agent，最多 17 个 Agent 并行
- 使用：在 Claude Code 里输入 `/seo` 查看命令，`/seo setup` 准备运行环境
- 安装：Skills CLI 可只装 seo 技能；完整插件用 `/plugin marketplace add AgriciDaniel/claude-seo`

（来源：[官方仓库](https://github.com/AgriciDaniel/claude-seo)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 21.5k stars | MIT 开源，更新活跃（v2.5.0） |
| 覆盖全面 | 技术 SEO、内容、Schema、GEO、本地与电商 |
| 报告能落地 | 按影响排序，并说明为什么重要、怎么验证 |
| 并行审计 | 最多 17 个 Agent 同时跑 |
| 有测试与 CI | 仓库自带测试，发布节奏稳定 |

| 需要注意 | 说明 |
|---|---|
| 主要面向 Claude Code | 完整功能依赖插件机制，其它客户端只能装技能 |
| 技能版功能不全 | 不含 19 个 Agent 与 /seo 命令 |
| 首次准备较重 | `/seo setup` 要建 Python 环境并下载无头浏览器 |
| 审计耗时 | 官方说完整审计约 10–15 分钟 |
| 结果仍需人工判断 | 建议按业务优先级取舍，不要照单全改 |

> 以上基于官方文档与社区反馈整理（2026-10-26），以官方最新文档为准。

## 快速部署（官方方式）

```bash
npx -y skills@latest add https://github.com/AgriciDaniel/claude-seo --skill seo -g -a trae trae-cn -y --copy
npx -y skills@latest list -g
```

部署步骤来源：[https://github.com/AgriciDaniel/claude-seo#install](https://github.com/AgriciDaniel/claude-seo#install)

## 验证状态

| 场景 | 状态 |
|---|---|
| 全局安装 seo 技能到 Trae（隔离 HOME 下执行） | 已验证 2026-10-26 |
| 完整插件（19 个 Agent + /seo 命令）未实测 | 已核对 2026-10-26 |
| MCP 服务握手与工具列表（initialize / tools/list） | 已验证 2026-10-26 |
| 非目标宿主调用被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-26 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

项目不是 MCP server，是 Claude Code 插件（含 SKILL.md 与 Agent 定义）。本仓库的 MCP 只提供安装步骤、客户端差异与常见坑。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-26）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\claude-seo-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 安装完成后：怎么用

1. 重启客户端，在对话里给出网址，说明要做 SEO 审计
2. 技能会按技术 SEO、内容、Schema、AI 搜索等维度检查，输出按优先级排序的行动清单
3. Claude Code 用户可用完整插件：`/plugin marketplace add AgriciDaniel/claude-seo` → `/plugin install claude-seo@agricidaniel-claude-seo` → `/seo setup`

### 只装了技能会缺什么

Skills CLI 只装 `skills/seo`，不包含 19 个专职 Agent 与 `/seo` 斜杠命令；完整报告质量会打折。要全套就用 Claude Code 的插件安装方式。

> `/seo setup` 会准备独立的 Python 环境与无头浏览器，不改动系统其它部分；`/seo doctor` 可随时自检。

## 常见坑

- 装完看不到技能：Skills CLI 默认装到 Trae / Trae CN，换客户端要改 `-a`
- `-g` 不带 `-a` 会装到所有客户端，遇到不支持全局安装的会整条失败
- 想用 `/seo` 命令必须先装完整插件，技能版没有斜杠命令
- `/seo setup` 失败：多为 Python 或浏览器下载问题，跑 `/seo doctor` 看具体项
- 审计需要抓取网站：内网或需要登录的站点可能抓不到
- 报告只是建议，改动前先备份，按影响大小分批上线

## 免责声明

本仓库为第三方指南，与 Claude SEO 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-26），项目迭代快，请以[官方文档](https://github.com/AgriciDaniel/claude-seo#install)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
