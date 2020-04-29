---
permalink: /
layout: splash

header:
  overlay_color: "#5e616c"
  overlay_image: https://www.debian.org/Pics/futureprototype-bg.png
  cta_label: "<i class='fa fa-download'></i> Stáhnout"
  cta_url: /stahnout-debian/
  caption: ''
excerpt: ''
intro:
  - excerpt: 'Při řešení problémů můžete navštívit [<i class="far fa-life-ring"></i> naše fórum](https://forum.debian-linux.cz/).'
---

{% include feature_row id="intro" type="center" %}

# Co je nového

{% include rss_feed.html id='rss-feed-root-cz-debian' rss=site.data.rss_feeds.rootcz-debian limit=4 %}
