remoteURL:=git@github.com:atomi/atomi.github.io.git
baseDir:=public
commit:=$(shell git describe --abbrev=10 --always --tags)

dev:  init
	hugo --bind=192.168.1.105 --baseUrl=192.168.1.105 server
deploy: init
	git clone $(remoteURL) $(baseDir)
	hugo
	cd $(baseDir); \
	git add *; \
	git commit -am "$(commit)"; \
	git push
	rm -rf public
init:
	go get -v github.com/spf13/hugo
update:
	go get -u github.com/spf13/hugo
