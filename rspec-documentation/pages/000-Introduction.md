# Introduction

_Betterp_ overwrites the default `p` and `pp` _Kernel_ methods to provide enhanced debug output including:

* Source file and line number of invocation.
* Colorized tags to help track debug output in noisy server logs.
* Profiling information (pass a block to `p` or `pp` to output call duration).


```rspec:ansi
require 'betterp'

subject { p 'hello' }

it { is_expected.to include 'hello' }
```
