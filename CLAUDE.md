# alex-skills

Alex 的个人 Claude Code 技能仓库。所有技能按分类管理，可通过 install 脚本部署到任意 Claude Code 环境。

## Skill 命名规范

- 目录名: `{category}-{name}`（全小写，连字符分隔）
- `SKILL.md` 必须包含 `name:` 和 `description:` frontmatter
- 同一分类的技能集中在 `skills/{category}/` 下

## 如何添加新 Skill

```
skills/{category}/{skill-name}/SKILL.md
```

SKILL.md 格式：

```markdown
---
name: my-skill
description: 技能简短描述
---

# 技能标题

## Step 1：...
...
```

## 与 baoyu-skills 的关系

本仓库管理的 `yiran-*` 技能是纯指令型（仅 SKILL.md，无可执行脚本），不依赖外部运行时。
baoyu-skills（`baoyu-image-gen`、`baoyu-post-to-wechat`）是来自 [baoyu-skills](https://github.com/JimLiu/baoyu-skills) 市场的插件，需要单独安装依赖（bun、Chrome、API keys），不作为本仓库内容管理。
