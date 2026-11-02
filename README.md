# my-sites-theme

A small shared Jekyll theme (plain CSS, no JavaScript, no Sass) for the QMRITools, Muscle Atlas, 7T MRI and Biomotive websites.

**Rule of thumb:** a feature that is useful for more than one site and does not conflict with the others goes in this repo. Site specific things stay in the site's own repo.

## Use it in a site

`Gemfile`:

```ruby
gem "my-sites-theme", github: "mfroeling/my-sites-theme", branch: "main"
```

`_config.yml`:

```yaml
theme: my-sites-theme
```

Then run `bundle install`. To update a site to the latest theme: `bundle update my-sites-theme`.
The site's `Gemfile.lock` pins the exact theme version, so a theme change never reaches a site until you update it there.

### Develop the theme and a site together

Point bundler at your local checkout, so you do not have to push after each edit. This needs `branch: "main"` in the Gemfile line above:

```
bundle config set --local local.my-sites-theme D:/werk/workspace/my-sites-theme
```

Commit your theme changes first (bundler records the local commit in `Gemfile.lock`). Undo with `bundle config unset --local local.my-sites-theme`, then push the theme and run `bundle update my-sites-theme` in the site.

## Override anything

A file in the site with the same path as a theme file wins. To change the footer, copy `_includes/_footer.html` into the site and edit it.
Use `_includes/_favicon.html` in each site for its own icon tags (the theme ships an empty one).

## What the theme provides

Layouts: `default`, `page`, `frontpage`, `redirect`.

| File | Use |
| --- | --- |
| `_includes/page-image` | `{% include page-image im_id='x' %}` shows the image with that `image_id` from the page's `images:` front matter, linked to the full size |
| `_includes/page-images` | `{% include page-images %}` shows all images in `images:` |
| `_includes/list-progress` | `{% include list-progress tag='x' %}` shows a grid of icons (the `icon:` file in each page's front matter) with the page title, for all pages with that tag |
| `_includes/list-research` | `{% include list-research tag='x' grp='y' %}` lists the pages that have both tags |
| `_includes/gallery` | `{% include gallery %}` thumbnail grid with a lightbox (no JavaScript) from the page's `gallery:` list (`image_url`, `caption`, `title`, optional `name`, `year`, `link`). The thumbnail of `a/b.jpg` must be `a/b-thumb.jpg` |
| `_includes/list-pages` | `{% include list-pages tag='x' %}` lists the pages with that tag |
| `_includes/_google_search` | simple Google site search box (used on the 404 page) |
| `_includes/sitemap_collection.xml` | used by the site's `sitemap.xml` page |

Page front matter: `style` (extra CSS for that page only), `title`, `subheadline`, `teaser`, `permalink`, `images`, `tags`, `meta_description` (optional, otherwise the first words of the page), `noindex: true`, `skip_boilerplate: true`.
Banner: `header: image_fullwidth: "banners/x.png"` shows a photo banner with the logo over it (file in `urlimg`); `header: title: "Text"` a text banner.
Front page (`layout: frontpage`): `widget1`, `widget2`, `widget3` (each `title`, `url`, `image`, `text`) and optional `callforaction` (`text`, `url`).
Redirect pages: `layout: redirect`, `permalink: /old/`, `redirect_to: /new/`, `sitemap: false`.

Menu: `_data/navigation.yml`, a list of `title`, `url` and an optional `dropdown` list of `title`, `url`. Links to `http...` or `.html` files open in a new tab.
Footer: `_data/services.yml`, `_data/network.yml`, `_data/socialmedia.yml` and `_data/language.yml` (a first entry with `menu_name` is the column title).

## Settings in the site's `_config.yml`

```yaml
title: 'Site name'
slogan: '...'
description: >-
  Used as the default description and in the footer.
url: "https://example.org"
baseurl: ''
urlimg: '/assets/images/'    # folder of the page images, with trailing slash
logo: "logo.png"             # file in urlimg, shown on the banner
credits: '<p>Website by ...</p>'
google_analytics_tracking_id: G-XXXXXXX   # optional
og_image: share.png          # optional, file in urlimg, used for link previews
custom_css: /assets/css/custom.css        # optional, extra site specific CSS
nav_first: true                           # optional, menu above the banner (default: banner first)
default_banner: false                     # optional, no logo banner on pages without header.image_fullwidth / header.title
about_url: /about/team/                   # optional, target of the More link in the footer (default /about/)
description_from_content: false           # optional, do not build the meta description from the first words of each page (use title + site description)
page_image_link: false                    # optional, do not link page images to the full size file
webp_images: true                         # optional, page-image uses name.webp instead of .png/.jpg when it exists
gif_as_video: true                        # optional, page-image shows name.gif as video when name.webm/.mp4 exist

theme_colors:                # optional, override the default colours
  accent: "#008cba"
  accent_dark: "#006687"
  bar: "#1f2933"
  banner_from: "#006687"
  banner_to: "#0b3a4d"
  bar_hover_text: "#13355f"   # optional text colour of a hovered menu item (default: bar_text)
  bar_active_text: "#13355f"  # optional text colour of the current menu item (default: bar_text)
  gallery_columns: 4        # thumbnails per row in the gallery (default 4, 2 on small screens)

jsonld:                      # optional extra structured data for the home page
  "@context": https://schema.org
  "@type": SoftwareSourceCode
  name: ...
```

## Notes

- Permalinks should end in a slash (`/seg/methods/`) and internal links should start with `/`, so pages work with and without the trailing slash.
- Structured data (schema.org JSON-LD) is added to every page: `WebSite` on the home page and `WebPage` elsewhere.
- Mobile layout is minimal (the menu wraps, wide tables scroll).
