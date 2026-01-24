# Identity Complex

A minimal, elegant Jekyll blog theme for GitHub Pages. Built with a dark aesthetic and focused on long-form technical writing.

## Quick Start

### Local Development

1. **Install dependencies:**
   ```bash
   bundle install
   ```

2. **Run the development server:**
   ```bash
   bundle exec jekyll serve
   ```

3. **View your site:**
   Open [http://localhost:4000](http://localhost:4000) in your browser.

### Deploy to GitHub Pages

1. Create a new repository on GitHub (e.g., `yourusername.github.io` for a user site, or any name for a project site)

2. Push this code to the repository:
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/yourusername/your-repo.git
   git push -u origin main
   ```

3. Enable GitHub Pages in your repository settings:
   - Go to **Settings** → **Pages**
   - Set source to **Deploy from a branch**
   - Select the **main** branch and **/ (root)** folder
   - Click **Save**

Your site will be live at `https://yourusername.github.io` (or `https://yourusername.github.io/your-repo` for project sites).

## Writing Posts

Create new posts in the `_posts/` directory with the filename format:

```
YYYY-MM-DD-your-post-title.md
```

Each post needs front matter at the top:

```yaml
---
layout: post
title: "Your Post Title"
subtitle: "Optional subtitle for the post"
date: 2026-01-23
categories: [category1, category2]
author: Your Name
---

Your content here in Markdown...
```

### Supported Markdown Features

- **Headers** (h2-h6 recommended, h1 is reserved for title)
- **Bold** and *italic* text
- `Inline code` and code blocks with syntax highlighting
- [Links](https://example.com)
- Blockquotes
- Ordered and unordered lists
- Images
- Horizontal rules

### Code Blocks

Use fenced code blocks with language specification for syntax highlighting:

~~~markdown
```python
def hello_world():
    print("Hello, World!")
```
~~~

## Customization

### Site Configuration

Edit `_config.yml` to customize:

```yaml
title: Identity Complex
description: "Your site description"
author: Your Name
url: "https://yourusername.github.io"
baseurl: "" # or "/your-repo" for project sites
```

### Styling

The theme uses CSS custom properties for easy customization. Edit `assets/css/style.css` to modify:

- **Colors** — Change the color scheme in the `:root` section
- **Typography** — Swap fonts by updating the `--font-*` variables
- **Spacing** — Adjust layout spacing with `--space-*` variables

### Adding Pages

Create new pages in the root directory as `.md` files:

```yaml
---
layout: page
title: Your Page Title
permalink: /your-page/
---

Your content here...
```

## File Structure

```
.
├── _config.yml          # Site configuration
├── _includes/           # Reusable HTML partials
│   ├── head.html
│   ├── header.html
│   └── footer.html
├── _layouts/            # Page templates
│   ├── default.html
│   ├── home.html
│   ├── page.html
│   └── post.html
├── _posts/              # Blog posts (Markdown)
├── assets/
│   └── css/
│       └── style.css    # Main stylesheet
├── about.md             # About page
├── index.html           # Homepage
├── Gemfile              # Ruby dependencies
└── README.md            # This file
```

## License

MIT License. Feel free to use, modify, and distribute.
