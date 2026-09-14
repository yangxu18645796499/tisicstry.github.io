# Tisicstry's Meditation

个人学习笔记站点，基于 [MkDocs Material](https://squidfunk.github.io/mkdocs-material/) 构建，部署在 <https://tisicstry.top/>。

## 本地预览

```bash
pip install -r requirements.txt
mkdocs serve
```

打开 <http://127.0.0.1:8000/> 实时预览。

## 构建

```bash
mkdocs build
```

生成的静态站点位于 `site/` 目录。

## 目录结构

- `docs/` —— 所有 Markdown 文档内容
- `mkdocs.yml` —— 站点配置与导航
- `.github/workflows/deploy.yml` —— 推送到 `main` 时自动部署到 GitHub Pages

## 新增文章

直接在 `docs/` 下对应目录新建 `.md` 文件，并在 `mkdocs.yml` 的 `nav` 中加入条目即可。
