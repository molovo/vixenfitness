---
title: Book a Session
slug: book
intro: Start Your Own<br /><span class="highlight--plum">fitness journey</span> Today.
layout: base
---

<section class="book__intro">
  <p>Save 5% by booking a block of 10 sessions or pay for a single session below. Get in touch to confirm available time slots.</p>
</section>

<section class="sessions">
  <article class="sessions__pricing">
    <ul class="sessions__price-list">
      {% assign products = site.products | sort: 'order' %}
      {% for product in products %}
        <li>
          <div class="sessions__item-content">
            <h2>{{ product.title }}</h2>
            <p>{{ product.content }}</p>
          </div>
          <div class="sessions__item-price">
            {% include add-to-basket-button.html product=product %}
          </div>
        </li>
      {% endfor %}
    </ul>
  </article>
</section>

{% include signup.html %}
