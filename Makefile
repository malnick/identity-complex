# Identity Complex — Jekyll blog
# Usage: make build | make post [TITLE=slug-for-filename]

POSTS_DIR := _posts
DATE     := $(shell date +%Y-%m-%d)
TITLE    ?= new-post
FILENAME := $(POSTS_DIR)/$(DATE)-$(TITLE).md

.PHONY: build post

build:
	bundle exec jekyll build

post:
	@mkdir -p $(POSTS_DIR)
	@{ echo '---'; echo 'layout: post'; echo 'title: ""'; echo 'subtitle: ""'; echo "date: $(DATE)"; echo 'categories: []'; echo 'author: Jeff Malnick'; echo '---'; echo ''; echo ''; } > "$(FILENAME)"
	@echo "Created $(FILENAME) — add title and content."
