# frozen_string_literal: true

require 'betterp'

class MyCustomClass # rubocop:disable Lint/EmptyClass
end

p 'hello'
p 'hi'
p 'debug output'
p 'hello', 'bob', 'how', 'are', 'you'
p(i: 'am', a: 'hash')
p MyCustomClass.new
p 'hello again'
p 'etc.'

def foo
  p 'hi from a method'
end

foo
