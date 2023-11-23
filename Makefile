project=betterp

.PHONY: test
test:
	bin/rspec
	bin/rubocop
	bin/strong_versions
	bundle exec rspec-documentation

.PHONY: publish
publish:
	@RSPEC_DOCUMENTATION_URL_ROOT='/$(project)' rspec-documentation
	@rsync --delete -r rspec-documentation/bundle/ docs.bob.frl:/var/www/html/$(project)/
	@echo 'Published.'
