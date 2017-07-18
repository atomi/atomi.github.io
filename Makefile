addkey:
	drone secret add -image atomi/hugo:* \
		-repository atomi/atomi.github.io -name ssh_key -value @/home/atomi/.ssh/id_rsa_github
sign:
	drone sign atomi/atomi.github.io
