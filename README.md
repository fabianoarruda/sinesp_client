
# Ruby Sinesp Client

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

Sinesp seems to block connections originated from outside of Brazil.

## Proxy

For Sinesp requests to work on international servers(Heroku, Digital Ocean, AWS etc.), you have to use a proxy service for requests coming from your application to Sinesp.

Example request with public proxy:

```ruby
require "sinesp_client"
SinespClient.search 'ABC1234', proxy_addr: "192.168.0.1", proxy_port: "8080"
```

Example request with private proxy, with user and password authentication:

```ruby
require "sinesp_client"
SinespClient.search 'ABC1234', proxy_addr: "192.168.0.1", proxy_port: "8080", proxy_user: "user", proxy_pass: "password"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. 

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fabianoarruda/sinesp_client.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

