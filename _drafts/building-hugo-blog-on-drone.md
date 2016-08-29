y---
Title: Building Hugo Blog on Drone
Date: 2016-08-28
---

I've been using Drone for a few months now and decided to jump on the 0.5 release a few days ago. Today I finally got Hugo builds working the way I want. But I had a few issues I had to resolve moving from 0.4.   

First, was that Drone 0.5 requires running an additional container, a drone agent, and using `DRONE_SECRET` is preferred.

Here's the meat:

```
# drone
docker run --detach \
  --name drone \
  -p 8000:8000 \
  -v /var/lib/drone:/var/lib/drone \
  -e DRONE_SECRET=Some-Secret-Passphrase \
  -e DRONE_GOGS=true \
  -e DRONE_GOGS_URL=https://gogs.atomi.space \
  -e GIN_MODE=debug \
  -e DRONE_ADMIN=atomi \
  -e DRONE_DEBUG=true \
  --restart always \
  drone/drone:0.5

# drone-agent
docker run --detach \
  --name drone-agent \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -e DRONE_SERVER=$DRONE_SERVER \
  -e DRONE_SECRET=$DRONE_SECRET \
  --restart always \
  drone/drone:0.5 agent    
```

Next was the new yaml configuration. This was easy. The new yaml is definitely an improvement and allows for a step process to your builds.  
