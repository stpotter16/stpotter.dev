+++
date = '2025-12-23'
title = 'Project Review - Biodata'
tags = ['projects']
+++
## Introduction

[Biodata](https://github.com/stpotter16/biodata) allows you to track a few personal health metrics like weight, waist, and blood pressure.

I've used other apps to do this in the past, but wanted to build my own for two reasons.

1. This felt like a tractable way to build a small "from scratch" application
2. I'm less and less comfortable sharing data of _any kind_ with _any third party_. Thank you AI...

Here's Biodata in action:

{{< figure src="images/biodata-demo.gif" title="Biodata demo" width="700" >}}

## Build it yourself

Because this was a silly side-project that will never see "production" use beyond my own purposes, I felt free to make choices I'd never make in a profesional context.
This frame of mind was reinforced by the fact that the application has a _very_ small functionality surface.

As such, I was able to "roll my own" solution to many common issues in web development, e.g.
- Sqlite and [Litestream](https://litestream.io/) for data persistence instead of something fancier like Postgres.
- Hand rolled JavasScript for user interactivity instead of a heavy framework like React (honestly the app is so minimal even [htmx](https://htmx.org/) felt like too much to pull in).
- Routing and middleware via Go's standard library instead of a dedicated routing library like [gorilla/mux](https://github.com/gorilla/mux)
- Deployment to a single little VPS instead of some over-archtected AWS solution.

## Thoughts on Go

Yes, I wish Go had better support for generics (though there was probably only one place in the project where generics would have been useful).

Yes, Go's error handling doesn't feel as cool/nice as Rust's or Zig's.

Yes, Go's type system isn't as strong as Rust's.

But...Go was still a super fun and easy langauge to use to write a small web application. The type system encouraged me to think about types, but not _overthink_ about them.
Similarly, I enjoyed how Go encouraged the minimalist mindset I had going into this project, e.g. a production ready web server in the standard library, straightforward middleware creation without dependencies, etc.

## Ready. Set. Learn.

Projects like this are all about utility and learning for me. In no particular order, I learned

- More about Nix (flakes, modules, packages, deployments).
- How to roll your own cookie authentication - with help from [this great tutorial](https://www.alexedwards.net/blog/working-with-cookies-in-go).
- How to handle [Cross Site Request Forgery](https://cheatsheetseries.owasp.org/cheatsheets/Cross-Site_Request_Forgery_Prevention_Cheat_Sheet.html).
- How to implement a [Content Security Policy](https://cheatsheetseries.owasp.org/cheatsheets/Content_Security_Policy_Cheat_Sheet.html).
- How to structure an application around the idea of ["Parse, don't validate"](https://lexi-lambda.github.io/blog/2019/11/05/parse-don-t-validate/).

## Nothing is perfect

The area I struggled with most was figuring out how to build and deploy the project to my VPS.

My VPS is a small machine running NixOS and I originally planned to run deploys following [this tutorial](https://mtlynch.io/notes/simple-go-web-service-nixos/), basically

1. ssh into the VPS
2. pull the lastest version of the application
3. rebuild the NixOS system to deploy the new version

The issue was that my VPS was so underpowered that it took a _very_ long time (hours) to build the new version of the application. I just didn't have the patience for that.

With AI's help (more on that below), I landed on a hacky-lite solution where I build the Nix package locally and then copy the built package to my VPS, symlink the executable and restart the service.
It's not as "Nixy" as it could be, but should work fine enough for now.

## The blind leading the blind

I used AI tools (Claude Code) all throughout developing this project.

Most times, I felt confident enough to guide the AI when it went down a weird rabbit hole, but there were moments, like finding my eventual deployment solution, where we both felt lost.

I'm sure those with more experience with deploying Nix packages would be able to tell me what I could do better and where the AI mislead me.

I think this is one of the subtle dangers developers need to be mindful of when using AI. It's easy to accept the AI's solutions to problems that are on the boundaries of your knowledge because you "know just enough to be dangerous".
The solution _seems_ feasible, but you lack enough real expertise to tell if you've actually drifted out into deeper water.

I don't really have a "solution" to that beyond "tread lightly", so maybe this is just a note-to-self.
