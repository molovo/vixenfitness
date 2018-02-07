---
title: Sessions and Packages
slug: book
intro: Start Your Own<br /><span class="highlight--plum">fitness journey</span> Today.
layout: base
---

<section class="book__intro">
  <p>Pay as you go sessions, one off programmes or discounted block bookings available. Get in touch for prices.</p>
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
