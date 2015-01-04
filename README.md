# Purolie

Purolie aims to provide a CLI way to get all the class parameters that will be used during a catalog compilation.

To make it clear given the following snippet

```puppet
# foo/manifests/init.pp
class foo (
  $param1 = 'param1',
  $param2 = 'param2',
) {
  include foo::bar
}

# foo/manifests/bar.pp
class foo::bar (
  $param3 = 'param3',
  $param4 = 'param4',
) {
}
```

`purolie ~/.puppet/modules/foo/manifests/init.pp` will output

```
#
# foo
#
foo::param1: 'param1'
foo::param2: 'param2'

#
# foo::bar
#
foo::bar::param3: 'param3'
foo::bar::param4: 'param4'
```

## Installation

Add this line to your application's Gemfile:

    gem 'purolie'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install purolie

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/purolie/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
