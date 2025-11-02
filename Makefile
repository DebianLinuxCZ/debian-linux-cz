export JEKYLL_ENV=production
HTML_PROOFER_OPTIONS=--disable-external=true
undefine BUNDLE_APP_CONFIG # let bundler use config from .bundle; in bash it would be 'unset BUNDLE_APP_CONFIG'

.DEFAULT_GOAL := all
.PHONY: all
all: prepare build check

.PHONY: all_in_container
all_in_container:
	bash ./scripts/run-in-container.sh make all JEKYLL_ENV='"$(JEKYLL_ENV)"' JEKYLL_OPTIONS='"$(JEKYLL_OPTIONS)"'

.PHONY: prepare
prepare:
	gem install --user-install --quiet --silent bundler -v "~> 2.6"
	bundle install --quiet

.PHONY: prepare_in_container
prepare_in_container:
	bash ./scripts/run-in-container.sh make prepare JEKYLL_ENV='"$(JEKYLL_ENV)"' JEKYLL_OPTIONS='"$(JEKYLL_OPTIONS)"'

.PHONY: clean
clean:
	bundle exec jekyll clean $(JEKYLL_OPTIONS)

.PHONY: clean_in_container
clean_in_container:
	bash ./scripts/run-in-container.sh make clean JEKYLL_ENV='"$(JEKYLL_ENV)"' JEKYLL_OPTIONS='"$(JEKYLL_OPTIONS)"'

.PHONY: build
build: clean
	JEKYLL_ENV='"$(JEKYLL_ENV)"' bundle exec jekyll build $(JEKYLL_OPTIONS)

.PHONY: build_in_container
build_in_container:
	bash ./scripts/run-in-container.sh make build JEKYLL_ENV='"$(JEKYLL_ENV)"' JEKYLL_OPTIONS='"$(JEKYLL_OPTIONS)"'

.PHONY: check
check:
	bundle exec htmlproofer _site $(HTML_PROOFER_OPTIONS)

.PHONY: check_in_container
check_in_container:
	bash ./scripts/run-in-container.sh make check JEKYLL_ENV='"$(JEKYLL_ENV)"' JEKYLL_OPTIONS='"$(JEKYLL_OPTIONS)"'

.PHONY: run
run: clean
	JEKYLL_ENV='"$(JEKYLL_ENV)"' bundle exec jekyll serve $(JEKYLL_OPTIONS)

.PHONY: run_in_container
run_in_container:
	bash ./scripts/run-in-container.sh make run JEKYLL_ENV='"$(JEKYLL_ENV)"' JEKYLL_OPTIONS='"$(JEKYLL_OPTIONS)"'
