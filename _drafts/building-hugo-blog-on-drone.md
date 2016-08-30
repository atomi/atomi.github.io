---
Title: Building Hugo Blog on Drone
Date: 2016-08-28
---

I've been using Drone for a few months now and decided to jump on the 0.5 release a few days ago. Today I finally got Hugo builds working the way I want. But I had a few issues I had to resolve before moving from 0.4.   

First, was that Drone 0.5 requires running an additional container, a drone agent that uses a `DRONE_SECRET` token to authorize.

To launch the containers customize your variables:

```bash
# do not use a trailing slash for the url
export GOGS_SERVER={http://gogsurl}
export DRONE_SERVER={http://droneurl}
export DRONE_SECRET={custom passphrase}
export GOGS_USER={gogs username}
```

Here are the commands to launch both the server and agent:

```bash
# drone server (set to debug for easier troubleshooting)
docker run --detach \
  --name drone \
  -p 8000:8000 \
  -v /var/lib/drone:/var/lib/drone \
  -e DRONE_SECRET=$DRONE_SECRET \
  -e DRONE_GOGS=true \
  -e DRONE_GOGS_URL=$GOGS_SERVER \
  -e GIN_MODE=debug \
  -e DRONE_ADMIN=$GOGS_USER \
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
I'm using Gogs in this case, but Drone works with Bitbucket and Github as well.    

Next was the new yaml configuration. This was easy. The new yaml is definitely an improvement and allows for a step process to your builds.  

Here is my `.drone.yml`

```
pipeline:
  publish:
    image: atomi/hugo
    commands:
    - eval $(ssh-agent);echo "$PRIVATE_KEY" | ssh-add /dev/stdin;
    - git config --global user.name 'atomi'; git config --global user.email 'example@gmail.com'
    - git clone git@github.com:atomi/atomi.github.io.git public;hugo
    - cd public; git commit -am '${DRONE_COMMIT:0:10}'
    - git push -u origin master
```

The interesting thing here is the use of `ssh-agent` and `ssh-add`. Since Drone 0.5 no longer provides deploy keys for improved security, you have to inject your own deploy keys, which is where drone-cli comes in.

Download the Drone CLI client and make sure the following environment variables are set so that `drone` command works properly:

```bash
# for drone-cli
export DRONE_SERVER={http://droneurl}
export DRONE_TOKEN={token from drone user interface}

# add our deploy key to $PRIVATE_KEY environment variable
drone secret add --image atomi/hugo atomi/atomi.github.io PRIVATE_KEY @/home/atomi/.ssh/id_rsa_atomi.github.io
```

As far as I know `drone secret add` puts any secret added into an environment variables. In the above case I add my private key to the $PRIVATE_KEY variable. The `--image atomi/hugo` restricts injection to only that image. My `.drone.yml` file can now make use of the $PRIVATE_KEY. `eval $(ssh-agent)` starts the `ssh-agent`, and `echo "$PRIVATE_KEY" | ssh-add /dev/std/in` adds our key to `ssh-agent` for our git+ssh authorizations.


