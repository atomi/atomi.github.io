addkey:
	drone secret add -image atomi/hugo:latest \
		-repository atomi/atomi.github.io -name SSH_KEY -value @/home/atomi/.ssh/id_rsa_github
