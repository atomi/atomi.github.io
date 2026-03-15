.PHONY: run build clean

clean:
	rm -rf public resources

run: clean
	hugo server -D

build: clean
	hugo
