---
name: yiran-wechat-prepare
description: 将「熠然之智」原始故事转为公众号可发布文章。改写风格、设计配图、生成图片、嵌入文章，全套自动化。
---

# yiran-wechat-prepare

将原始故事转为微信公众号可发布文章。

## 前置条件

- 项目路径：`/Users/niuniu/Library/Mobile Documents/com~apple~CloudDocs/obsidian-space/30 项目/熠然之智/`
- DashScope API Key 有可用额度
- 本地环境：bun 已安装
- `source/story.md` 已存在
- `ian-xiaohei-illustrations` 的参考文件已安装（位于 `~/.claude/plugins/marketplaces/ian-xiaohei/skills/ian-xiaohei-illustrations/references/`）

---

## Step 1：分析故事 → 配图策略

读取 `source/story.md`，分析故事中的认知锚点（适合配图的场景）。

输出 shot list（1 张封面 + 4~6 张内文配图），每张图包含：

| 字段 | 说明 |
|------|------|
| 场景 | 故事中的具体段落/情节 |
| 结构类型 | 从 `ian-xiaohei` 的 `composition-patterns.md` 中选择一种：Workflow / 系统局部 / 前后对比 / 角色状态 / 概念隐喻 / 方法分层 |
| 小黑动作 | 小黑在图中做什么（参考 `ian-xiaohei-illustrations` 的小黑 IP 动作库构思，必须参与核心动作） |
| 中文标注 | 1-2 个简短标注词 |
| 画面描述 | 给 ian-xiaohei-illustrations 的参考描述 |
| 比例 | 封面 2.35:1 / 内文 16:9 |

**⚠️ 输出 shot list 后立即请求用户确认，确认后才进入 Step 2。不要等用户主动发起"确认"，在技能内一次性完成：分析→输出→询问确认。**

> 封面固定尺寸规则（写在约束汇总里，但要在这一步就记住）：
> - 封面图：必须用 `--size "1920*817"`（不能用 `--ar 2.35:1`，DashScope 部分模型不支持）
> - 内文配图：`--ar 16:9 --quality 2k`
>
> 构图设计原则（来自 ian-xiaohei《构图模式与原创规则》）：
> - 每张图选一至两种结构即可，不要混太多
> - 一个核心动作/结构/状态/隐喻
> - 不要复刻旧案例构图，每次从当前故事重新发明一个奇怪但成立的隐喻

---

## Step 2：改写为公众号文章

输出：`01-wechat/article.md`

规则（严格执行，逐条检查）：

| # | 规则 | 说明 |
|---|------|------|
| 1 | **title 无 emoji** | frontmatter `title:` 和正文 `# H1` 都不加 emoji |
| 2 | 短段落 | 每段不超过 5 行，手机阅读 |
| 3 | 增加引导语 | 开头的引用块 `>` |
| 4 | 分隔段落 | 用 `---` 分隔大段 |
| 5 | 结尾互动 | `📌 如果是你，你会怎么选？评论区聊聊` |
| 6 | 关注引导 | `**👇 点击关注「熠然之智」**` + 名片位说明 |
| 7 | 保留概念解释 | 隐喻对照表保留 |
| 8 | 系列署名 | 文末 `「熠然之智 🌱 成长系列」—— 帮少年理解世界不是非黑即白。` |

## Step 3：生成配图

### 执行方式

使用 `baoyu-image-gen` 工具 + DashScope 逐张生成。
但生图前 **必须加载 ian-xiaohei-illustrations 的参考文件**来确保风格：

| 参考文件 | 用在哪 |
|---------|--------|
| `references/style-dna.md` | 颜色规则、留白比例、禁忌清单 |
| `references/xiaohei-ip.md` | 小黑形象、动作库（确保小黑参与核心动作） |
| `references/prompt-template.md` | 生图 prompt 的标准结构 |
| `references/qa-checklist.md` | 生成后逐条验证 |

具体步骤：

1. **加载参考文件** —— 读取以上 4 个文件，理解风格标准

2. **按 shot list 逐张生成** —— 每张图独立调用 `baoyu-image-gen`：
   - 内文配图：`--ar 16:9 --quality 2k`
   - 封面图：`--size "1920*817"`（不能用 `--ar 2.35:1`）
   - prompt 按 `prompt-template.md` 的结构写
   - 每张图只讲一个核心结构

3. **每张图用 QA checklist 验证** —— 出现以下情况重生成：
   - 小黑只是装饰（不是核心动作）
   - 画面太满（主体 > 60%）
   - 左上角有"常见坑 / Workflow"等标题
   - 有纸纹、阴影、渐变的背景
   - 画风太可爱 / 太 PPT / 太像旧案例

4. 保存到 `01-wechat/assets/`，命名规则：
   ```
   01-scene-name.png
   02-scene-name.png
   ...
   cover-2351.png
   ```

5. 生成完成后继续 Step 4（嵌入配图）。

## Step 4：嵌入配图到文章

在 article.md 中，每张图放在对应段落后面：

```markdown
![图注文字](assets/01-xxx.png)
*图注说明文字*
```

封面图不上传到文章，留给用户手动设置。

## Step 5：收尾报告

完成后输出：
- 文章路径
- 配图数量
- 封面路径（2.35:1）
- 下一步建议（发布 / 小红书 / 视频）
- ⚠️ 提醒用户发布前：
  - 手动填写摘要
  - 勾选 AI 生成声明
  - 关联合集
  - 插入公众号名片

---

## 约束汇总（踩坑记录）

| 问题 | 对策 |
|------|------|
| ❌ title 含 emoji 导致保存失败 | frontmatter title + H1 都不加 emoji |
| ❌ 封面图比例不对导致裁剪 | 必须用 `--size "1920*817"` 生成 |
| ❌ API 发布失败 | 跳过，用浏览器方式发布 |
| ❌ 配图风格走样 | Step 3 加载 ian-xiaohei 参考文件（style-dna, xiaohei-ip, prompt-template, QA-checklist）后生图 |
