# 🧰 alex-skills

Alex 的 Claude Code 个人技能集。通过 GitHub 统一管理，可安装到任意 Claude Code 环境。

## 技能列表

### 📢 yiran — 熠然之智公众号

| 技能 | 用途 | 类型 |
|------|------|------|
| `yiran-storyweaver` | 生成系列寓言故事（深度/通识/成长/童心/社会） | 纯指令 |
| `yiran-story-review` | 自动审核、润色故事，最多 3 轮循环 | 纯指令 |
| `yiran-wechat-prepare` | 改写公众号文章 + 生成配图 + 嵌入文章 | 纯指令 |

### 📦 更多分类（按需扩展）

_空分类占位，后续添加：工具类、工作流、代码审查……_

## 安装

### 快速安装

```bash
git clone https://github.com/niuniu/alex-skills.git ~/.claude/skills/alex-skills
# 或使用项目自带安装脚本
cd ~/.claude/skills/alex-skills
bash scripts/install.sh
```

### 安装脚本做了什么

`scripts/install.sh` 将 `skills/` 下的每个子目录创建符号链接到 `~/.claude/skills/`，Claude Code 会自动发现这些技能。

### 验证安装

在 Claude Code 中输入 `/` 查看技能列表，应出现对应技能名称。

## 卸载

```bash
bash scripts/uninstall.sh
```

## 依赖

本仓库技能均为**纯指令型**（仅有 SKILL.md），不依赖外部运行时。

如需配图生成和公众号发布能力，还需安装 [baoyu-skills](https://github.com/JimLiu/baoyu-skills) 市场插件及其依赖（bun、Chrome、API keys）。

## 开发

1. 在 `skills/` 下创建新技能目录
2. 编写 `SKILL.md`
3. 在 `CLAUDE.md` 中更新技能列表
4. 提交 PR

## 约定

- SKILL.md 使用标准的 `name` + `description` frontmatter
- 技能名用小写连字符
- 分类前缀作为目录名（如 `yiran-storyweaver`）
