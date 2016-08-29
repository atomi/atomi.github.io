---
Title: Building Hugo Blog on Drone
Date: 2016-08-28
---

I've been using Drone for a few months now and decided to jump on the 0.5 release a few days ago. Today I finally got Hugo builds working the way I want. But I had a few issues I had to resolve moving from 0.4.   

First, was that Drone 0.5 requires running an additional container, a drone agent, and using `DRONE_SECRET` to authorize it.

Next was the new yaml configuration. This was easy. The new yaml is definitely an improvement and allows for a step process to your builds.  

