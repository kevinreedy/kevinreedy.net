---
layout: post
title: Introducing Hive Runner
date: 2013-08-28 11:34 CDT
---

At Belly, we are all about data. We make frequent iterations to products and internal processes and track how well the iterations succeed. We understand the importance of A/B testing, and one of the many tools we use to make decisions from those tests is Apache Hive.

Hive is a data warehouse tool for Apache Hadoop originally written by Facebook. Hive provides a SQL-like interface into large data sets in Hadoop, which makes summarizing large amounts of data very easy for both developers and non-developers. Hive Query Language (HiveQL) saves users the trouble of having to write or understand typical map/reduce jobs.

<!-- more -->

Every employee at Belly has the ability to query our user data to make informed decisions. With summarized data in mind, we can customize our platform and products to provide the best experience possible for our users.

For example, we ran a test to determine which color button on our in-store merchant tablet app received the highest engagement, based on conversions indexed against prior performance and adjusted for daily trends and seasonality. We found that the addition of animation on the homescreen, versus variants in button color, drove higher engagement rates by an impressive margin. While not as significant, changing the color of the button also impacted user behavior. With such impressive results, we switched to the new color and animated button. That decision was backed by data.

Hive also gives us insight into optimizing when to send email to our users. We found that our users on average open more email that is sent around 5pm CST than any other period in the day (with individual time partitions, adjusted for time zones, showing distinct and consistent performance across all email metrics regardless of industry or location). While many tools can provide this kind of insight, Hive allows us to connect multiple sources of data and find the connections between them.

With data supporting our decisions, we make better connections with our users so they can get more out of the loyalty service we provide.

## Belly's Hadoop Infrastructure

At Belly, we run Cloudera's distribution of Hadoop on dedicated servers. While most of our infrastructure runs on Amazon Web Services, dedicated servers give us much better network, disk, and CPU performance per dollar. However, we do lose the ability to quickly scale up or down our Hadoop infrastructure while on dedicated servers.

Data is loaded into our Hadoop infrastructure using Fluentd, which is an open-source tool for collecting and aggregating JSON logs. In addition to writing our data to Hadoop, Fluentd is also configured to write our data to Amazon S3 for archiving/backup and to RabbitMQ for real-time streaming of event data.

Most of Belly's employees interact with our Hadoop Infrastructure via Cloudera Hue, which is a Web UI for Hadoop. Beeswax is a tool within Hue for interacting with Hive and allows users to run queries, save and edit queries, view query results, and view table metadata.

## The Missing Puzzle Piece

While Hive and Beeswax are great for doing one-off queries into our data, we wanted a simple way for any employee to run a Hive query on a schedule - hourly, daily, or weekly. Existing tools like Apache Oozie and Airbnb's Chronos are either too complicated or overkill for this task. We wanted a UI for scheduling queries that was immediately familiar to all of our users and their broad range of experience levels.

We wrote [Hive Runner](https://github.com/bellycard/hiverunner) to fill this gap. Hive Runner is a python script that pulls saved queries from Beeswax, runs the queries on Hive, and stores the results in Memcache. Other tools of ours can then get the results from Memcache instantly without having to wait for a Hive query to run. Any employee can set up a scheduled query by simply making a saved query in Beeswax and naming the query starting with `_hourly`, `_daily`, or `_weekly`. We have three cron jobs scheduled at those intervals to run Hive Runner.

We also have an internal tool that standardizes the creation of custom D3 charts to visually convey a large set of data. These dashboards visualize our data to tell a complete story for a product. The data set for these charts is easily retrieved from the Memcache store without the need for a system engineer or back-end developer to do any more configuration. Hive Runner makes the data available for any client to consume.

## Using Hive Runner

### Requirements

* **Python 2.7**
* **Cloudera Beeswax**: Beeswax, which is a part of Cloudera Hue, must be using a MySQL Database for its storage, rather than SQLite.
* **HiveServer**: You must be running HiveServer version 1. Note that Cloudera's Hadoop distribution only ships with version 2. You can easily install version 1 using Cloudera's package repositories.
* **Memcached**: You must have Memcached running somewhere.
* **Pip**: Pip is used for Python package dependency.

### Installation

* Optionally, create a VirtualEnv: `virtualenv environment-name`
* Optionally, use your VirtualEnv: `source environment-name/bin/activate`
* Install Hive Runner via pip: `pip install hiverunner`

### Usage

Hive Runner has flexible parameters. Available options can be seen by running `hiverunner --help`.

For example, to run all queries in Beeswax prepended with `_hourly` and caching the results in memcache:

```
hiverunner --hourly \
--mysql-host mysql01.example.com \
--mysql-database beeswax \
--mysql-user hue \
--mysql-password secret \
--hive-host hive01.example.com \
--memcache-host cache01.example.com
```

You can run the same command for all queries prepended with `_weekly` simply by changing the hourly parameter to weekly:

```
hiverunner --weekly \
--mysql-host mysql01.example.com \
--mysql-database beeswax \
--mysql-user hue \
--mysql-password secret \
--hive-host hive01.example.com \
--memcache-host cache01.example.com
```

If you find that you need to run custom named queries or only a single query the `custom` parameter makes this easy. Simply provide the name of the query that must be run.

For example, to run a single query regardless of the prepended time-focused demarcation:

```
hiverunner --custom _daily_custom_query \
--mysql-host mysql01.example.com \
--mysql-database beeswax \
--mysql-user hue \
--mysql-password secret \
--hive-host hive01.example.com \
--memcache-host cache01.example.com
```

This format makes it easy to schedule cron jobs.

Hive Runner is open source software and available at [GitHub](https://github.com/bellycard/hiverunner). Bug reports, feature requests, and contributions are welcome!

## Further Reading

* [Hive](http://hive.apache.org/)
* [Hadopp](http://hadoop.apache.org/)
* [Fluentd](http://fluentd.org/)
* [Hue](http://cloudera.github.io/hue/)
* [Apache Oozie](http://oozie.apache.org/)
* [Chronos: A Replacement for Cron](http://nerds.airbnb.com/introducing-chronos/)

Mirrored from [Belly's Tech Blog](https://tech.bellycard.com/blog/introducing-hive-runner/)
