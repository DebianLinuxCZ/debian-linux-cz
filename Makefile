export JEKYLL_ENV ?= production
HTML_PROOFER_OPTIONS=--disable-external
undefine BUNDLE_APP_CONFIG # let bundler use config from .bundle; in bash it would be 'unset BUNDLE_APP_CONFIG'

.DEFAULT_GOAL := all
.PHONY: all
all: prepare build check

.PHONY: all_in_container
all_in_container:
	bash ./scripts/run-in-container.sh make all JEKYLL_ENV='$(JEKYLL_ENV)' JEKYLL_OPTIONS='"$(JEKYLL_OPTIONS)"'

.PHONY: prepare_raw
prepare_raw:
	gem install --user-install --quiet --silent bundler -v "~> 2.6"
	bundle install --quiet

.PHONY: prepare_ci
prepare_ci: prepare_raw

.PHONY: prepare
prepare: prepare_raw

.PHONY: prepare_in_container
prepare_in_container:
	bash ./scripts/run-in-container.sh make prepare_raw JEKYLL_ENV='$(JEKYLL_ENV)' JEKYLL_OPTIONS='"$(JEKYLL_OPTIONS)"'

.PHONY: clean_raw
clean_raw:
	bundle exec jekyll clean $(JEKYLL_OPTIONS)

.PHONY: clean
clean: clean_raw

.PHONY: clean_in_container
clean_in_container:
	bash ./scripts/run-in-container.sh make clean_raw JEKYLL_ENV='$(JEKYLL_ENV)' JEKYLL_OPTIONS='"$(JEKYLL_OPTIONS)"'

.PHONY: build_raw
build_raw: clean_raw
	JEKYLL_ENV='$(JEKYLL_ENV)' bundle exec jekyll build $(JEKYLL_OPTIONS)

.PHONY: build_ci
build_ci: build_raw

.PHONY: build
build: build_raw

.PHONY: build_in_container
build_in_container:
	bash ./scripts/run-in-container.sh make build_raw JEKYLL_ENV='$(JEKYLL_ENV)' JEKYLL_OPTIONS='"$(JEKYLL_OPTIONS)"'

.PHONY: check_raw
check_raw:
	bundle exec htmlproofer _site $(HTML_PROOFER_OPTIONS)

.PHONY: check_ci
check_ci: check_raw

.PHONY: check
check: check_raw

.PHONY: check_in_container
check_in_container:
	bash ./scripts/run-in-container.sh make check_raw JEKYLL_ENV='$(JEKYLL_ENV)' JEKYLL_OPTIONS='"$(JEKYLL_OPTIONS)"'

.PHONY: run_raw
run_raw: clean_raw
	JEKYLL_ENV='$(JEKYLL_ENV)' bundle exec jekyll serve --host '0.0.0.0' $(JEKYLL_OPTIONS)

.PHONY: run
run: run_raw

.PHONY: run_in_container
run_in_container:
	bash ./scripts/run-in-container.sh make run_raw JEKYLL_ENV='$(JEKYLL_ENV)' JEKYLL_OPTIONS='"$(JEKYLL_OPTIONS)"'
