---
name: yiran-auto-pipeline
description: 一条命令跑完熠然之智全流程：生成故事 → 改写公众号 → 配图生成 → 嵌入文章。发布需要你单独确认。
---

# yiran-auto-pipeline

将 `yiran-storyweaver`（故事生成）和 `yiran-wechat-prepare`（公众号改写 + 配图）串成一条自动化流水线。你只需审核最终成品，不再干预中间步骤。

## 工作流

### Step 1：确定系列和概念

确认参数 —— 你一次性给定，不问第二遍：

- **系列**：深度 / 通识 / 成长 / 童心 / 社会
- **概念**：从该系列概念池选一个（或自由输入）

### Step 2：生成故事

执行 `yiran-storyweaver` 的工作流：

1. 用系列和概念生成故事（1500-2000 字寓言）
2. 创建目录结构（`YYYYMMDD-序号-[系列]故事标题/`）
3. 保存 `source/story.md` + `source/prompt.md`
4. 更新索引（系列页 + _index.md + _todo.md）

> 此时故事是 draft 状态，后续会自动处理。

### Step 3：公众号改写 + 配图

执行 `yiran-wechat-prepare` 的工作流（跳过 shot list 确认步骤——因为是多次跑通的流程，默认信任上一步的配图决策）：

1. **Step 1 配图策略** — 分析故事，输出 shot list（不需要你确认，直接继续）
2. **Step 2 改写文章** — 输出 `01-wechat/article.md`
3. **Step 3 生成配图** — 根据 series 字段自动选 IP：
   - 🧸 童心 → 小点（加载 `tongxin-xiaodian-illustrations` 参考文件）
   - 其他 → 小黑（加载 `ian-xiaohei-illustrations` 参考文件）
   - 用 `baoyu-image-gen` + DashScope 逐张生成
   - 用对应 IP 的 QA checklist 验证
4. **Step 4 嵌入配图** — 图片嵌入 article.md

### Step 4：交付审核

输出审核清单：

```
## 交付清单

系列：🧸 童心
概念：诚实
标题：xxxxx
字数：xxx 字
配图：x 张（封面 + 内文）
文章路径：xxx/01-wechat/article.md

请审核：
[ ] 故事质量
[ ] 配图风格
[ ] 文章格式
确认后告诉我"发布"或"修改"。
```

### Step 5：等待指令

- **你说"发布"** → 调用 `baoyu-post-to-wechat` 发布到公众号草稿箱
- **你说"修改 xxx"** → 按你的要求修改对应部分，重新交付
- **你说"重做"** → 重新走 Step 2（新生成）

## 前置条件

同 `yiran-wechat-prepare`：
- bun 已安装
- DashScope API Key 有可用额度
- ian-xiaohei-illustrations 参考文件可用
- tongxin-xiaodian-illustrations 参考文件可用
- baoyu-image-gen 可用
