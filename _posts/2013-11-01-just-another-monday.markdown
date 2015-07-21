---
layout: post
title: Just Another Monday
date: 2013-11-01 13:00 CDT
---

A large portion of my day-to-day work at Belly is in a supporting role, which means I get interrupted quite a bit. To combat this, I try to work remotely every once in a while. It's a great change of pace and allows me to make significant progress on a single task. Usually this means I work from home, but sometimes a couple of us on the backend team work together out of coffee shops on a single project.

At the end of August, I took a short mid-week trip to The Twin Cities to visit a couple of friends and go to the Minnesota State Fair. Trust me - the state fair is way more awesome than you think it is. Thanks to my friend [Eryn](https://twitter.com/eryno), I was able to work for two days out of [Clockwork Active Media's](http://www.clockwork.net/) incredible office. While I was there, Eryn asked me, "What do you sysadmins actually *do* all day? Look at graphs and cat pictures?" I responded with, "Not quite, but this could be a most excellent blog post."

<!-- more -->

Here is a breakdown of a Monday earlier this month with some more details below.

 * **09:00** - Arrive to work and catch up on email from overnight.
 * **09:30** - Attend our [weekly fireside meeting](#Weekly Fireside Meeting).
 * **10:00** - [Dave](https://twitter.com/davearel) tells several of us that there is free breakfast downstairs. Sadly, there was none to be found.
 * **♫ Now Listening ♫** - [Hannah Wants - Mixtape 0913](https://soundcloud.com/hannah_wants/hannah-wants-mixtape-0913)
 * **10:15** - Get report that our service that interfaces with Salesforce isn't working correctly. The issue ends up being that the password for the account we use for this service was changed. This invalidated the API keys with this account. I regenerate the API keys, update the configuration, and push the change.
 * **11:15** - [Jon](https://github.com/jonwhite) brings in a Chromecast into the office for the TV near our engineering team. I start casting our [Check-ins Map](#Check-ins Map) to the TV.
 * **11:30** - Go outside to the [food trucks](#Food Trucks) for lunch.
 * **12:30** - Start work on improving our [event definitions repository](#Event Definitions Repository).
 * **♫ Now Listening ♫** - [Claude VonStroke - Live from Kazantip 2013](https://soundcloud.com/flapj4ck/claude-vonstroke-live-from)
 * **13:30** - Catch up with [Christian](https://twitter.com/christianvozar) about a bug causing one of our services not to restart on deploy.
 * **14:00** - Get paged. It ends up being a few slow MySQL queries during a migration during a deploy.
 * **14:10** - Update AWS IAM permissions for [Eric](https://twitter.com/erickerr).
 * **14:15** - Start work on replacing our Github deploy key strategy.
 * **15:30** - Give [MySQL access](#MySQL Access) to an Account Manager.
 * **15:45** - Deploy a new service with [Darby](https://twitter.com/darbyfrey).
 * **♫ Now Listening ♫** - [Breach - Essential Mix](https://soundcloud.com/breach-uk/breach-radio-1-essential-mix-6)
 * **16:00** - Configure [Vagrant](http://www.vagrantup.com/) for our event scripts repository.
 * **16:45** - Configure [Travis CI](http://about.travis-ci.org/) for our event definitions and event scripts repositories.
 * **17:30** - Give [Joe](https://twitter.com/joedivs) an Intro to [Chef](https://www.chef.io/) and how we use it at Belly.
 * **18:00** - Head home for the day.

<a name="Weekly Fireside Meeting"></a>

## Weekly Fireside Meeting

On Monday mornings, the entire engineering team gathers around the couches for a quick status update of ongoing projects and what we plan to work on that week. This is a bit longer than a stand-up meeting, but we intentionally stay out of a conference room to keep this short.

<a name="Check-ins Map"></a>

## Check-ins Map

During a hack time in the past, [Marty](https://twitter.com/martytrzpit) wanted to create a real time map of Check-ins. While I'm sure this warrants its own blog post, here is a short description of how we created it.

We currently use [Fluentd](http://fluentd.org/) to pass around our event logs. The output of these logs at the time was only S3 and Hadoop's HDFS. I was able to quickly add another output - [RabbitMQ](http://www.rabbitmq.com/). Marty and [AJ](https://twitter.com/ajself) wrote a quick Node.js app to subscribe to check-in events on this queue, send them to a browser using WebSockets, and render them on a map using [D3.js](http://d3js.org/).

<a name="Food Trucks"></a>

## Food Trucks

While we do have a great office, there are not very many options for lunch nearby. Fortunately, between two and seven food trucks come by the office every day. Some of my personal favorites are [The Fat Shallot](https://twitter.com/thefatshallot), [The Roost](https://twitter.com/TheRoostTruck), [Windy City Patty Wagon](https://twitter.com/WattyPagon), and [The Southern Mac & Cheese Truck](https://twitter.com/thesouthernmac).

<a name="Event Definitions Repository"></a>

## Event Definitions Repository

We have a large number of events that we log from many sources including our mobile apps, our API, and Salesforce. These events are defined in a series of YAML files that used to be in the git repository of the one application that used them. Here's an example of one event definition:

```yaml
api_created_check_in:
  description: Generated by our API every time a user checks in at a business
  parameters:
    <<: *user
    <<: *client
    <<: *checkin
    insecure_mode: boolean
    offline_checkin: boolean
    checkin_at: timestamp
```

As you can see, we use a great deal of inheritance in these definitions, as many events share the same attributes.

Because we now have several applications that need access to these files, the definitions are now in their own repository. Miscellaneous scripts for our event data were also moved into their own repository.

<a name="MySQL Access"></a>

## MySQL Access
We have a MySQL slave that is dedicated for ad-hoc queries, but it isn't open to the public internet or our office network. We require using an SSH Tunnel and connecting with a passphrase-encrypted SSH key rather than a password.

Mirrored from [Belly's Tech Blog](https://tech.bellycard.com/blog/just-another-monday/)
