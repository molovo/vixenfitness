---
title: Home
layout: base
---

<section class="intro">
  {% include logo.html %}

  <img src="/uploads/gemma.jpg" alt="Portrait of Gemma Holloway" />

  <p>
    I'm Gemma Holloway, a 28 year old mummy from South East England.
  </p>
</section>

<section class="links">
  <div class="links--latest-blog">
    <h6>Latest Blog Post</h6>

    {% assign post = site.posts.first %}
    <h4>
      <a href="{{ post.url }}">{{ post.title }}</a>
    </h4>

    {{ post.description }}
  </div>

  <div class="links--latest-recipe">
    <h6>Latest Recipe</h6>

    {% assign recipe = site.recipes.first %}
    <h4>
      <a href="{{ recipe.url }}">{{ recipe.title }}</a>
    </h4>

    {{ recipe.description }}
  </div>
</section>
