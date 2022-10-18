# Close

This a ruby gem that provides a robust way to interact with the Close
CRM API.

It will have many features.

- [ ] Request Caching
- [ ] Request Throttling / Queueing for rate limits
- [ ] Full Documentation

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'close'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install close

## Configuration

The gem can be configures in the following ways:

Environment Variables

- `CLOSE_API_KEY` - Your Close API key

Block Configuration
    
```ruby
Close.configure do |config|
    config.api_key = 'YOUR_API_KEY'
end
```


## Usage

## Documentation

Aside from this README, you can find the documentation for this gem at [rubydoc.info](https://www.rubydoc.info/gems/close).

You can also generate the documentation locally by running:

    $ bundle exec rake yard



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/close. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/close/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Close project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/close/blob/master/CODE_OF_CONDUCT.md).
