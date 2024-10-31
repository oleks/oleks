.PHONY: help build deploy

help:
	@echo "Usage: make [build|deploy]"

build:
	cd oleks.info && cabal run site build

deploy: build
	rsync -av -r oleks.info/_site/ oleks@oleks.info:/home/oleks/oleks.info
