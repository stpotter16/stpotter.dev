+++
date = '2026-05-20'
title = 'Project Review - Dump'
tags = ['projects']
+++
## Introduction

[Dump](https://github.com/stpotter16/dump) is a tool I built to help me capture items and help get rid of "open loops" (borrowing David Allen's terms).

It allows users to enter items into a simple text box and then review that list. On the backend, a text embedding service I built as a companion project, [Embeder](https://github.com/stpotter16/embeder), stores the idea's embedding so I can see similar items when reviewing the list

Here's Dump in action:

{{< figure src="images/dump-demo.gif" title="Dump demo" width="700" >}}

## Why build Dump

In the past, I would email myself the items and then process them in batches later.

It was often aggravating to open my email intending to send myself a quick note and then get distracted by something in my inbox.

Additionally, I would often forget that I'd already sent myself an email and would send the TODO multiple times. For example, I sent myself some version of the same email everytime I walked past our leaking kitchen faucet yesterday.

## Deeper appreciation for model serving

Working through this project gave me a deeper appreciation for what it takes to run AI inference workfloads.

Cold starting the server for even small models takes a significant amount of time (3-5s for the ONNX version of `all-minilm-l6-v2 model`). That's much longer than most clients are willing to wait.

A pattern of having Dump's server retry in a background thread while Embeder warmed up works for a small personal project, but wouldn't scale to any real production workload.

## Really pushing AI usage

I leaned heavily on AI for this project, handing over the reins for both design and implementation choices.

I still need to invest more heavily in building safe sandboxes for the agents to work in. I would be more comfortable letting them loose if they had strong isolation.

