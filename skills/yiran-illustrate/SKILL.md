---
name: yiran-illustrate
description: 为「熠然之智」所有系列生成正文配图。根据 series 字段自动匹配 IP 和视觉风格。支持 🧸童心(小点) 🌱成长(小芽) 🧠通识(小林) 🔬深度(小镜) 🌏社会(小网)。
---

# yiran-illustrate

为熠然之智 5 个系列统一生成配图。读 `source/story.md` 的 `series` 字段，自动匹配该系列的 IP、视觉风格和 QA 标准。

## 前置条件

- `source/story.md` 存在且包含 `series:` frontmatter
- `baoyu-image-gen` 可用（DashScope）
- `config/series-map.md` 定义了系列-目录映射

## 文件结构

```
series/
├── tongxin/      ← 🧸 童心 → 小点（白色圆点+淡彩光晕）
├── chengzhang/   ← 🌱 成长 → 小芽（绿色嫩芽）
├── tongshi/      ← 🧠 通识 → 小林（小黑+圆框眼镜）
├── shendu/       ← 🔬 深度 → 小镜（棱镜多面体）
└── shehui/       ← 🌏 社会 → 小网（节点+连接线）

每个系列目录包含：
  ip.md             角色/结构定义、动作库
  style-dna.md      视觉风格（背景/线条/颜色/禁忌）
  prompt-template.md 生图提示词模板
  qa-checklist.md   质量验证标准
```

## 工作流

### Step 1：读取系列

```
source/story.md frontmatter series: 字段
```

支持的 5 个值（严格匹配）：

| frontmatter `series:` | 系列 | IP | 目录 |
|----------------------|------|----|------|
| 童心                 | 🧸 童心 | 小点 | `series/tongxin/` |
| 成长                 | 🌱 成长 | 小芽 | `series/chengzhang/` |
| 通识                 | 🧠 通识 | 小林 | `series/tongshi/` |
| 深度                 | 🔬 深度 | 小镜 | `series/shendu/` |
| 社会                 | 🌏 社会 | 小网 | `series/shehui/` |

### Step 2：加载系列参考文件

加载对应目录下的 4 个文件：

```
series/{name}/ip.md            → 理解 IP 形象、动作库
series/{name}/style-dna.md     → 理解视觉风格（颜色/留白/禁忌）
series/{name}/prompt-template.md → 生图 prompt 结构
series/{name}/qa-checklist.md  → 生成后验证标准
```

### Step 3：出 shot list

按该系列的视觉风格和 IP 动作库，设计每张图的方案。

每张图包含：

| 字段 | 说明 |
|------|------|
| 场景 | 故事中的具体段落 |
| IP 动作 | 该系列的 IP 在图中做什么（参考 ip.md 动作库） |
| 结构类型 | 根据该系列 style-dna 选取合适类型 |
| 标注词 | 1-3 个该系列颜色规则下的中文标注 |
| 比例 | 封面 2.35:1 / 内文 16:9 |

**原则**：
- 每张图只讲一个核心结构/瞬间
- IP 必须参与核心动作，不是装饰
- 不要复刻旧案例构图
- 封面单独设计（`--size "1920*817"`）

### Step 4：逐张生成

用 `baoyu-image-gen` + DashScope：

1. 按 `prompt-template.md` 的结构写生图 prompt
2. 内文：`--ar 16:9 --quality 2k`
3. 封面：`--size "1920*817"`
4. 每张图独立生成，不要多张拼一起

### Step 5：QA 验证

每张图生成后立刻用 `qa-checklist.md` 逐条验证：

- **不通过 → 立即重生成**，不等到最后
- 常见失败信号：
  - IP 只是装饰（去掉 IP 画面还能成立）
  - 画面太满（主体 > 60%）
  - 左上角有标题
  - 颜色规则不匹配
  - 画风太 PPT / 太可爱 / 太商业

### Step 6：嵌入配图

把图片嵌入文章（由调用方负责，本技能只输出到指定目录）。

## 封面规则（所有系列通用）

```
--size "1920*817"（不能用 --ar 2.35:1，DashScope 部分模型不支持）
```

封面也需要使用该系列的 IP 和风格，但构图更简洁——适合做文章头图。

## 添加新系列

1. 在 `series/` 下创建目录
2. 写 4 个参考文件（ip.md, style-dna.md, prompt-template.md, qa-checklist.md）
3. 在 `config/series-map.md` 中添加映射行
4. 在本 SKILL.md 的 Step 1 表格中添加新行
