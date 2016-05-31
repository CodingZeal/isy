# Isy

[![Build Status](https://travis-ci.org/acuppy/isy.svg?branch=master)](https://travis-ci.org/acuppy/isy)
[![Code Climate](https://codeclimate.com/github/acuppy/isy/badges/gpa.svg)](https://codeclimate.com/github/acuppy/isy)

Guard clauses for argument type assertions can be messy:

```ruby
def fullname segments=[]
  raise ArgumentError, 'User#fullname expects 'segments' to be an Array' if segments.is_a? Array
  # ...
end
```

Setting aside that an issue of this type could be a sign of a greater
architectural problem, `Isy` takes a declarative approach to solving the problem.
Instead of dictating the contraints (and resulting response) to each argument type,
you can leverage Isy's simple interface:

## Usage

The primary use of Isy is through the `isy` method, which is included into Object upon initialization

You can call isy from any point, but it's intended use is to be treated like a "guard clause" to
assert method argument types before those arguments are used (and potentially wreak havoc
throughout the implementation:

```ruby
def fullname segments=[]
  isy segments, Array
  # ...
end
```

The first argument is the subject of the test (i.e. what should match the proceeding assertion)
The second argument is the type.

If the subject doesn't match the provided type, then it raises a formatted exception describing
what argument *value* was a type mismatch (as an `Isy::ArgumentTypeMismatch` exception).

## Usage with an operation

Optionally, in place of a type as the second argument, you can pass a block, and perform
a more complex comparison operation:

```ruby
  def fullname segments
    isy segments { |seg| seg.length == 3 }
    # ...
  end
```

As illustrated above, `isy` yields to the operation the first argument (segments).  The expectation
is that the value returned by the operation (block) is a boolen (true => passes, false => failed).

## Performance

It's not great against a more "native" implementation; but, where you lose a little
in performance, you (may) gain in an ability to quickly reason about the
code.

A native implementation is incredibly light (see above): no additional dependencies
and logistical overhead.  Using `Isy` you're introducing an additional dependency and
better support for evaluation routines (by providing a block).

To run a comparison benchmark:

`$ ruby spec/benchmark.rb`

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'isy'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/isy. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

Copyright (c) 2016 Adam Cuppy, Zeal (https://codingzeal.com)
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
