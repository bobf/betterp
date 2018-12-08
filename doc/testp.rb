require 'betterp'

class MyCustomClass
end

p 'hello'
p 'hi'
p 'debug output'
p *%w[hello bob how are you]
p({ i: 'am', a: 'hash' })
p MyCustomClass.new
p 'hello again'
p 'etc.'

def foo
  p 'hi from a method'
end

foo
