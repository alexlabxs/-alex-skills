---
name: html-card-xiaohongshu
description: 生成小红书图文卡片（莫兰迪风格），输出可截图的 HTML → PNG。适配 02-xiaohongshu/ 目录。
---

# 小红书图文卡片

生成小红书风格知识卡片组，多张连排，莫兰迪色系，适合截图发布。

## 输出路径

- 保存到故事目录下的 `02-xiaohongshu/assets/`
- HTML 源码保留在 `02-xiaohongshu/index.html`

## 工作流

### 1. 分析内容

确定卡片数量：
- 短内容 3-6 张
- 长内容 6-9 张
- 封面 + 正文 + 总结

### 2. 生成 HTML

Tailwind CDN + 自定义 CSS，1080×1440 每张：

格式：
```html
<main class="cards">
  <!-- 封面 -->
  <section class="card cover">
    <div class="tag">干货预警</div>
    <h1>标题</h1>
    <p class="sub">副标题</p>
  </section>
  <!-- 正文页 N 张 -->
  <section class="card">
    <div class="emoji">🚀</div>
    <h2>核心观点</h2>
    <ul><li>要点</li></ul>
  </section>
  <!-- 尾页 -->
  <section class="card closing">
    <h2>总结</h2>
    <p>行动号召</p>
  </section>
</main>
```

### 3. 样式

- 莫兰迪色系：soft pink / sage green / dusty blue / warm beige
- 圆润元素 (`border-radius: 24px`)，大量留白
- 大字号（标题 48-64px，正文 24-28px）
- 每张右下角水印（熠然之智 + 日期）
- 渐变色卡片背景，纯白卡片内容区

### 4. 嵌入 example.html

`assets/example.html` 作为渲染参考。用 Playwright 或系统 Chrome 截图为 PNG，保存到 `02-xiaohongshu/assets/`。

### 5. 命名

```
xhs-01-cover.png
xhs-02-xxx.png
...
```
