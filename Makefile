remoteURL:=git@github.com:atomi/atomi.github.io.git
pubDir:=public
commit:=$(shell git describe --abbrev=10 --always --tags)
hugo:=github.com/spf13/hugo

dev:  init
	hugo --bind=192.168.1.105 --baseUrl=192.168.1.105 server
deploy: init
	git clone $(remoteURL) $(pubDir)
	hugo
	-cd $(pubDir); git add -A; git commit -am "$(commit)"; git push
	rm -rf public
init:
	go get -v $(hugo)
update:
	go get -u $(hugo)
