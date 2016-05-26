remoteURL:=git@github.com:atomi/atomi.github.io.git
baseDir:=public
commit:=$(shell git describe --abbrev=7 --always --tags)

deploy: init
	git clone $(remoteURL) $(baseDir)
	hugo
	cd $(baseDir); \
	git add *; \
	git commit -am "Pushing commit $(commit)"; \
	git push
	rm -rf public
init:
	go get -v github.com/spf13/hugo
