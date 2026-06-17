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

### Step 2.5：人性化处理（去除 AI 痕迹）

调用 `humanizer-zh` 技能处理 `source/story.md`：

1. **识别 AI 模式** — 扫描破折号过度使用、三段式法则、填充短语、金句感等痕迹
2. **重写问题片段** — 保持原意不变，让文字更自然、更像人类书写
3. **保留该系列的叙事风格** — 童心系列保留简单重复句，成长保留青少年语感，通识/深度/社会保留各自的调性
4. **保存修改** — 覆盖 `source/story.md`

### Step 3：公众号改写 + 配图

执行 `yiran-wechat-prepare` 的工作流（跳过 shot list 确认步骤——因为是多次跑通的流程，默认信任上一步的配图决策）：

1. **Step 1 配图策略** — 分析故事，输出 shot list（不需要你确认，直接继续）
2. **Step 2 改写文章** — 输出 `01-wechat/article.md`
3. **Step 3 生成配图** — 加载 `yiran-illustrate` 系列的参考文件，按该系列的 IP、风格、QA 标准执行：
   - 加载 `yiran-illustrate/config/series-map.md` 确定目录
   - 加载对应 `yiran-illustrate/series/{name}/` 下的 4 个参考文件
   - 用 `baoyu-image-gen` + DashScope 逐张生成
   - **每张图生成后立即用该系列的 qa-checklist 验证**，不通过立即重生成
4. **Step 4 嵌入配图** — 图片嵌入 article.md

### Step 4：交付审核

输出审核清单，**必须包含 shot list 摘要**——让用户看到每张图的配图策略：

```
## 交付清单

系列：🧸 童心
概念：诚实
标题：xxxxx
字数：xxx 字
文章路径：xxx/01-wechat/article.md

### 配图策略

| # | 场景 | IP 动作 | 结构类型 |
|:-:|------|---------|---------|
| 🖼️ 封面 | 小兔子站树下看蛋 | [IP]照亮/钻出/思考/折射/连接 | 角色状态 |
| ❶ | [核心场景] | [IP 动作] | 结构类型 |
| ❷ | [核心场景] | [IP 动作] | 结构类型 |
| ❸ | [核心场景] | [IP 动作] | 结构类型 |
| ❹ | [核心场景] | [IP 动作] | 结构类型 |

### 请审核

- [ ] 故事质量
- [ ] 配图方向（shot list 逻辑是否合理）
- [ ] 配图风格（IP 使用是否正确）
- [ ] 文章格式
- [ ] 封面图是否合适（手动设置用）

确认后告诉我"发布"或"修改"。
```

### Step 5：等待指令

- **你说"发布"** → 先清理旧 Chrome CDP 连接，再发布：

  ```bash
  # 清理上次残留的 Chrome CDP 会话，避免页面状态冲突
  pkill -f "chrome-profile.*remote-debugging" 2>/dev/null; sleep 2
  ```

  然后调用 `baoyu-post-to-wechat`（浏览器方式）发布到公众号草稿箱。

  **发布成功后自动更新索引：**
  - `_todo.md`：待发布 → 公众号已发布 ✅
  - 对应系列页（如 `🧸童心系列.md`）：草稿 📝 → 已发布 ✅

  **然后自动生成小红书图文：**
  - 调用 `guizang-social-card-skill` 将文章转为小红书图文卡片
  - 使用电子杂志风（Editorial）风格，适配 3:4 组图
  - 输出到 `02-xiaohongshu/` 目录
  - 更新 `_todo.md`：公众号已发布 ✅ → 小红书已生成 ✅

- **你说"修改 xxx"** → 按你的要求修改对应部分，重新交付
- **你说"重做"** → 重新走 Step 2（新生成）

## 前置条件

同 `yiran-wechat-prepare`：
- bun 已安装
- DashScope API Key 有可用额度
- ian-xiaohei-illustrations 参考文件可用
- tongxin-xiaodian-illustrations 参考文件可用
- baoyu-image-gen 可用
