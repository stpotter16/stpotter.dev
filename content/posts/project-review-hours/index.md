+++
date = '2026-05-15'
title = 'Project Review - Hours'
tags = ['projects']
+++
## Introduction

[Hours](https://github.com/stpotter16/hours) allows you to create projects and track how long you have worked on them.

There are many, many other applications that solve this problem (most much more effectively than hours).

I built Hours for two reasons.

1. I wanted to build a CLI app in Go. This was a great opportunity to try that out.
2. I was curious to experience how sharing types between client and server shaped development. TL;DR - I loved it.

Here's Hours in action:

{{< figure src="images/hours-demo.gif" title="Hours demo" width="700" >}}

## The Joy of Small

I love building small, "complete" tools like Hours.

The simpicity and smallness makes it easier to avoid having to reach for third-party tools and just rely on Go's standard library.

The limited scope of what the tool needs to do means I can actually _finish_ the project instead of getting it to 90% and calling it good enough.

