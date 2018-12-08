# betterp

## Overview

_betterp_ is _Ruby_'s default `p` but with a few extra benefits.

The standard `Kernel#p` method is overwritten with a version that provides the following features:

* All output is prefixed with the file and line number that made the call to `p`
* Output is colourised. The colour is selected using a hash of the file path and line number so the colours are stable.

The original semantics of `Kernel#p` are still applied, i.e. it returns the value it was passed and the original implementation is used to generate the output string.

## Installation

Add the gem to your `Gemfile`

```ruby
gem 'strong_versions', '~> 0.3.0'
```

And rebuild your bundle:

```bash
$ bundle install
```

Or install yourself:
```bash
$ gem install strong_versions -v '0.3.0'
```

## Usage

Use `p` just as you usually would and enjoy.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bobf/betterp
