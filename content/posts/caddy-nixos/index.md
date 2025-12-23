+++
date = '2025-11-03'
title = 'Configure Caddy on NixOS to serve a static site'
tags = ['notes']
+++
## Introduction

[Caddy](https://caddyserver.com/) is a HTTP web server, much like nginx or Traefik.
One of Caddy's unique features is that it attempts to automatically secure Let's Encrypt SSL certificates for the domains it is serving. 
This saves me the hassle of securing and configuring those certificates myself (and setting up a process to automatically renew them).

This post will show how to run and configure Caddy on a NixOS machine to serve a static site

## Serving a static site from NixOS with Caddy

### Configuration
Caddy is already available as a service in NixOS so configuring it is as simple as including it in your `configuration.nix` file.

Here's a sample configuration for a static site against the domains `www.example.com` and `example.com`

```
{
  services.caddy = {
    enable = true;
    virtualHosts."example.com".extraConfig = ''
      encode gzip
      root * /var/www/html/example
      file_server {
        hide .git LICENSE
      }
    '';
    virtualHosts."www.example.com".extraConfig = ''
      encode gzip
      root * /var/www/html/example
      file_server {
        hide .git LICENSE
      }
    '';
  };
  
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
```

### Gotchas
Make sure you've properly configured DNS records for your domain(s) before enabling Caddy. If you don't, Caddy might have issues fetching a certificate.

I am running Caddy on a VM so I needed to add A type DNS records for `www` (the subdomain) and `@` (the root domain) pointing to my server's IP address.

Depending on your setup, you may need different DNS records.

