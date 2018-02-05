
# Ruby Sinesp Client

[![Build Status](https://travis-ci.org/fabianoarruda/sinesp_client.svg?branch=master)](https://travis-ci.org/fabianoarruda/sinesp_client)

This gem provides a client for searching vehicle data based on the license plate from Sinesp database. This data is publicly available at https://www.sinesp.gov.br/sinesp-cidadao. The gem just makes it easier to fetch results, through the same endpoint used by the mobile app. 

For a python version, please check this: https://github.com/victor-torres/sinesp-client

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sinesp_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sinesp_client

## Usage

```ruby
require "sinesp_client"
SinespClient.search 'ABC1234'
```

Returns a hash with basic vehicle data.

## Limitations

Sinesp seems to block connections originated from outside of Brazil. TODO: make the gem work with proxy.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. 

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fabianoarruda/sinesp_client.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

