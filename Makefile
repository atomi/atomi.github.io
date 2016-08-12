commit:=$(shell git describe --abbrev=10 --always --tags)

dev:
	hugo --bind=127.0.0.1 --baseUrl=127.0.0.1 server
deploy:
	git clone git@github.com:atomi/atomi.github.io.git public
	hugo
	cd public; git add -A; git commit -am "$(commit)"; git push -u origin master
clean:
	rm -rf public
hugo:
	go get -u -v github.com/spf13/hugo
