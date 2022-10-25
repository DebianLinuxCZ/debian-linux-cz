export JEKYLL_ENV=production
HTML_PROOFER_OPTIONS=--disable-external=true
undefine BUNDLE_APP_CONFIG # let bundler use config from .bundle; in bash it would be 'unset BUNDLE_APP_CONFIG'

.DEFAULT_GOAL := all
.PHONY: all
all: prepare build check

.PHONY: prepare
prepare:
	gem install bundler -v "~> 2.3"
	bundle install

.PHONY: clean
clean:
	bundle exec jekyll clean

.PHONY: build
build: clean
	bundle exec jekyll build

.PHONY: check
check:
	bundle exec htmlproofer _site $(HTML_PROOFER_OPTIONS)

.PHONY: run
run: clean
	bundle exec jekyll serve

.PHONY: all_in_container
all_in_container:
	JEKYLL_ENV=$(JEKYLL_ENV) bash ./scripts/run-in-container.sh make all
