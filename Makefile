export JEKYLL_ENV=production
HTML_PROOFER_OPTIONS=--disable-external=true --ignore-urls="/feed/"
undefine BUNDLE_APP_CONFIG # let bundler use config from .bundle; in bash it would be 'unset BUNDLE_APP_CONFIG'

.DEFAULT_GOAL := all
.PHONY: all
all: prepare build check

.PHONY: prepare
prepare:
	gem install bundler -v "~> 2.3"
	bundle install

.PHONY: feeds_to_posts
feeds_to_posts:
	bundle exec pluto update ./planet.ini
	bundle exec ruby ./_lib/planet.rb/planet.rb

.PHONY: build
build:
	make feeds_to_posts
	bundle exec jekyll build

.PHONY: check
check:
	bundle exec htmlproofer _site $(HTML_PROOFER_OPTIONS)

.PHONY: run
run:
	make feeds_to_posts
	bundle exec jekyll serve

.PHONY: all_in_container
all_in_container:
	JEKYLL_ENV=$(JEKYLL_ENV) bash ./scripts/run-in-container.sh make all
