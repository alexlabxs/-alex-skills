---
name: html-card-twitter
description: 生成 Twitter/X 分享卡（16:9 金句卡），输出可截图 HTML → PNG。
---

# Twitter/X 分享卡

生成高对比度金句卡，截图后直接配推文发出。

## 输出路径

- 保存到 `twitter-cards/` 或用户指定目录

## 工作流

### 1. 分析内容

- 核心金句（2-3 行）
- 作者 + handle
- 类型标签（Insight / Data / Quote）
- 情绪决定暗色或亮色主题

### 2. 生成 HTML

Tailwind CDN，1600×900：

```html
<section class="card dark">
  <div class="label">Insight</div>
  <blockquote class="hero">金句</blockquote>
  <div class="author">
    <div class="avatar"></div>
    <span>@handle</span>
  </div>
  <div class="watermark">brand</div>
</section>
```

### 3. 样式

- 暗色：深灰背景 + 白字 + 霓虹强调色（青/紫）
- 亮色：米白背景 + 深灰字 + 暖色强调
- Grid 网格 / noise 纹理底
- 中央金句（text-6xl, semibold, 限 2-3 行）
- 右下角品牌水印

### 4. 截图

用 Playwright 或系统 Chrome 截图保存。
