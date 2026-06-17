# Series → directory mapping for yiran-illustrate

# The SKILL.md reads source/story.md frontmatter `series:` field
# and loads the corresponding series directory below.

| series: value (frontmatter) | Directory     | IP   | Target audience     |
|-----------------------------|---------------|------|---------------------|
| 童心                        | `tongxin`     | 小点 | 家长（亲子共读）     |
| 成长                        | `chengzhang`  | 小芽 | 中学生·家长         |
| 通识                        | `tongshi`     | 小林 | 大众读者（主力）     |
| 深度                        | `shendu`      | 小镜 | 知识从业者          |
| 社会                        | `shehui`      | 小网 | 关心时事的大众       |

# Each series directory must contain these files:
#   - ip.md          角色定义、动作库
#   - style-dna.md   视觉风格（背景/线条/颜色规则/禁忌）
#   - prompt-template.md  生图提示词模板
#   - qa-checklist.md     质量标准

# Adding a new series:
#   1. Add a row here
#   2. Create series/{name}/ with the 4 required files
#   3. Done — SKILL.md reads this map automatically
