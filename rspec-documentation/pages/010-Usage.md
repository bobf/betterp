# Usage

Typical usage of _Betterp_ is identical to usage of `Kernel.p` and `Kernel.pp`, simply require `betterp` somewhere in your project and call `#p` or `#pp` as normal.

```rspec:ansi
subject { p 'hi' }

it { is_expected.to include 'hi' }
```

```rspec:ansi
subject { pp({ foo: 'bar', baz: 'qux' }) }

it { is_expected.to include 'qux' }
```

## Profiling

Both `#p` and `#pp` can receive a block. If a block is received, the block will be timed and the execution time will be included in the output. The result of the block is returned to the caller.

```rspec:ansi
subject do
  p { sleep(0.1); 'some return value' }
end

it { is_expected.to match /\dms/ }
```

The execution time is highlighted in `green`, `yellow`, or `red` depending on execution time.

The default thresholds are:

* `low`: `< 10ms`.
* `high`: `> 100ms`.

The thresholds can be modified:

```ruby
Betterp.configure do |config|
  config.profiling_threshold.low = 100
  config.profiling_threshold.high = 1000
end
```
