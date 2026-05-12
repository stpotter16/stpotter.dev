+++
date = '2026-05-11'
title = 'Migrating services from Linode to Fly.io'
tags = ['notes']
+++
## Introduction

I migrated my handful of small personal projects from a [Linode VPS](https://www.linode.com/) to [Fly.io](https://fly.io/).

This post will explain why I migrated and how I did it.

## Why migrate

Running a NixOS VPS was a lot of fun and I learned a bunch about deploying and managing services on NixOS.

However, as the number of projects I was trying to run grew in number I found myself dealing more and more with distracting sysadmin issues.

Fly allows me to focus on the part of the process I like, i.e. developing the application.

## Creating new services in Fly

I created a new `fly.toml` file in the root of each project (see below for an example) and ran `fly launch --no-deploy` to create a new app.

Once I was ready to deploy, I simply ran `fly deploy` to create the machines backing the app.

```
app = 'com-app'
primary_region = 'iad'
kill_signal = 'SIGINT'
kill_timeout = '30s'

[experimental]
  auto_rollback = true

[build]
  [build.args]
    GO_VERSION = '1.25.2'

[env]
  DB_PATH = '/data/db'
  PORT = '8080'

[http_service]
  internal_port = 8080
  force_https = true
  auto_stop_machines = 'stop'
  auto_start_machines = true
  min_machines_running = 0
  processes = ['app']

[[services]]
  protocol = 'tcp'
  internal_port = 8080
  processes = ['app']

  [[services.ports]]
    port = 80
    handlers = ['http']

  [[services.ports]]
    port = 443
    handlers = ['tls', 'http']

  [services.concurrency]
    type = 'connections'
    hard_limit = 25
    soft_limit = 20

  [[services.tcp_checks]]
    interval = '15s'
    timeout = '2s'
    grace_period = '1s'

[[vm]]
  memory = '1gb'
  cpu_kind = 'shared'
  cpus = 1
  memory_mb = 1024
```

I want to highlight two items from the configuration.

### Application naming

I tend to "namespace" my apps using a Java-like structure

### Kill Signal & Kill Timeout

I configured the app to send a `SIGINT` and wait a long time (30s) before sending `SIGKILL` in an attempt to give Litestream lots of time to spin down.

## Migrating DNS

After running `fly deploy` the applications were allocated IPv4 and IPv6 addresses.

I created `A` and `AAAA` records with my DNS provider pointing to these addresses and then ran `fly certs add` to secure certificates.

## Shutting down Linode

Now I was ready to migrate the application data from the Linode VPS.

I shut down the Linode VPS so it would no longer be trying to write data to the Litestream backup. I did not delete it yet in case I needed to roll back the migration

## Configuring per-bucket keys for Litestream backups

One detail of my Linode VPS setup that I wasn't especially fond of was the fact that the Litestream `systemd` service was backing up databases to multiple buckets so it used API keys with very broad permissions.

Migrating each of these databases to their own services on Fly allowed me to create per-application API keys for the Litestream backup service, each of which had tigher permission scope.

## Getting everything working

From here everything basically Just Worked{{< super "TM" >}}

The only small tweak I made was turning down the replication frequency of Litestream to one second so that it was sure to capture all database changes before the app machines scaled to zero

## Clean up

Now all that was left was to clean up by fully deleting the old Linode VPS and the broad API keys it was using for Litestream backups.

