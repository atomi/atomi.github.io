addkey:
	drone secret add --image atomi/hugo:* atomi/atomi.github.io SSH_KEY @/home/atomi/.ssh/id_rsa_github
sign:
	drone sign atomi/atomi.github.io
