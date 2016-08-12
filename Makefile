remoteURL:=git@github.com:atomi/atomi.github.io.git
pubDir:=public
commit:=$(shell git describe --abbrev=10 --always --tags)
hugo:=github.com/spf13/hugo
GOPATH:=$(shell echo $$GOPATH)

dev:  init
	hugo --bind=127.0.0.1 --baseUrl=127.0.0.1 server
deploy: init
	git clone $(remoteURL) $(pubDir)
	hugo
	-cd $(pubDir); git add -A; git commit -am "$(commit)"; git push origin master
	rm -rf public
init:
	GOPATH=$(GOPATH) go get -v $(hugo)
