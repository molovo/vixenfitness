---
title: Book a Session
slug: book
intro: Start Your Own<br /><span class="highlight--plum">Fitness Journey</span> Today.
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
            <a href="#" class="button button--buy" data-name="Vixen Fitness" data-description="{{ product.title }}" data-amount="{{ product.price | times: 100 | round }}">
              <span class="button__text">Book Now</span>
              <span class="button__text button__text--price">£{{ product.price | round }}</span>
              {% if product.badge %}
                <span class="button__badge">{{ product.badge }}</span>
              {% endif %}
            </a>
          </div>
        </li>
      {% endfor %}
    </ul>
  </article>
</section>

{% include signup.html %}
