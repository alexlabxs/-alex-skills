---
name: html-video-hyperframes
description: 生成 Hyperframes/Remotion 兼容的视频帧序列，适配 03-video/ 目录。
---

# Hyperframes 视频帧

生成连续视频帧（1920×1080），可自动播放预览，兼容 Remotion / Hyperframes 渲染。

## 输出路径

- 保存到故事目录下的 `03-video/assets/`
- HTML 源码保留在 `03-video/index.html`

## 工作流

### 1. 分析内容

规划帧序列：
- 第 1 帧：Hook（数据/反常识/问题）
- 第 2-N 帧：论证展开
- 最后帧：结论 + CTA

短脚本 6-10 帧，长脚本更多。

### 2. 生成 HTML

Tailwind CDN，1920×1080 每帧，自动播放 JS：

```html
<main id="player">
  <section class="frame" data-duration="3000" data-transition="fade">
    <h1>Hook 标题</h1>
    <p>副文本</p>
  </section>
  ...
</main>
```

### 3. 样式

- 电影感动画：深色背景 + 1 个霓虹强调色
- 巨大学号（text-9xl），一句话一帧
- 每帧底部隐藏 `<meta>` 供 Remotion 读取
- 顶部的 auto-play JavaScript + 进度条

### 4. 元数据

HTML 末尾包含：
```html
<!-- HYPERFRAMES_META: {frames: [{duration:3000, transition:"fade", sceneSummary:"..."}]} -->
```

### 5. 截图

用 Playwright 或系统 Chrome 截取每帧为 PNG，保存到 `03-video/assets/`。
命名：`frame-01-hook.png`, `frame-02-xxx.png`
