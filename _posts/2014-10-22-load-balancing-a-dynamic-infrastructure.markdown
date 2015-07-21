---
layout: post
title: "Load Balancing a Dynamic Infrastructure with Nginx, Chef, and Consul"
date: 2014-10-22 13:00 PST
---

Load balancing and routing traffic to a single application is easy, but sending traffic to a always-changing number of applications is quite a challenge. In the last year, [Belly](https://www.bellycard.com) has migrated from a monolithic Rails app to a service-oriented architecture with over fifty applications.

In this session at [nginx.conf](https://www.nginx.com/nginxconf/) 2014, I talked about how to use [Chef](https://www.chef.io/) and [Consul](https://www.consul.io/) to dynamically configure [NGINX](https://www.nginx.com/) to route and load balance traffic across applications.

<!-- more -->

### Video

<iframe width="740" height="416" src="https://www.youtube.com/embed/A2NOziRYh7U" frameborder="0" allowfullscreen></iframe>

### Slides

<script async class="speakerdeck-embed" data-id="a6450b803c5f0132ed0b3a2ff4764c03" data-ratio="1.33333333333333" src="//speakerdeck.com/assets/embed.js"></script>
