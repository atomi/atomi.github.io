addkey:
	drone secret add --image atomi/hugo:armhf atomi/atomi.github.io PRIVATE_KEY @/home/atomi/.ssh/id_rsa_github
sign:
	drone sign atomi/atomi.github.io
