+++
date = '2025-09-16'
draft = true
title = 'NixOs on Linode'
+++
## Introduction

Linode does not *officially* support NixOS out of the box, but they do have a
relatively [comprehensive guide](https://www.linode.com/docs/guides/install-nixos-on-linode/)
for installing it from scratch.

I found the instructions pretty easy to follow, but there were a few nuances that tripped me up here and there.
What follows is a re-hash of that guide with specific emphasis on parts that *I* struggled with. As with anything else, your mileage will vary.

## Configuring the disk images
This was the core stumbling block for me. The instructions tell you to create three disk images - one for the installer, one for the OS, and one for swap.

I made the mistake of trying to reuse the OS disk image that comes with the default distribution. This lead to issues booting later on.

I also discovered that the guide's sizing recommendation for the installer disk was out of date. Instead of the 1208 MB size recommended, I used 5000 MB to accomodate the NixOS minimal iso.

Here's what the disk image setup looked like when I had it setup correctly.

{{< figure src="images/disk_images.webp" title="Correct disk image setup" width="700" >}}

## Wrapping up
Once the disk images were correctly setup, the rest of the install went smoothly!

