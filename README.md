# Close

[![Gem Version](https://badge.fury.io/rb/close.svg)](https://badge.fury.io/rb/close) [![Test Coverage](https://api.codeclimate.com/v1/badges/d83380e81bfb459ea027/test_coverage)](https://codeclimate.com/github/joynerd/close/test_coverage)

This a ruby gem that provides a robust way to interact with the Close
CRM API.

It will have many features.

- [ ] Request Caching
- [ ] Request Throttling / Queueing for rate limits
- [ ] Full Documentation
- [ ] Full Test Coverage
- [ ] Full API Coverage
- [ ] Full Child Object Instances

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

Block Configuration
    
```ruby
# Block configuration
Close.configure do |config|
    config.api_key = 'YOUR_API_KEY'
end
# One off settings
Close.configuration.api_key = 'YOUR_API_KEY'
```


## Usage

This gem works by creating resource objects that represent resources on 
the Close API. These objects can be used to make requests to the API.

```ruby

# Example Using Leads:

# Get a list of leads
leads = Close::Lead.list

# Get a single lead
lead = Close::Lead.retrieve('lead_id')

# Update the name (and other attributes) of a lead. These are not persisted to the API until you call save.
lead.name = 'New Name'

# Save the changes
lead.save

```

## Supported Resources

### Advanced Filters
[Close API Docs](https://developer.close.com/resources/leads/)

Advanced Filters are a clever way to open up search to the API, with the caveat that they are very dense and appear to be written in search DSL (Elastic, Solr, etc).

I have tried to encapsulate the complexity of the DSL into a simple interface that is easy to use. This is mostly by defining queries before
they are run and then running them with parameters when they are needed.

An example of an advanced filter query:

```ruby
# Run a prebuilt query
Close::AdvancedFilter.run('find_leads_by_email', {email: 'buster.bluth@gmail.com'})

# Add a new query
Close::AdvancedFilter.add('find_leads_by_phone_number', {phone_number: '%PHONE_NUMBER%'})

# Run the new query
Close::AdvancedFilter.run('find_leads_by_phone_number', {phone_number: '555-555-5555'})
```

If you think you have a common query or one that would be useful to others, please open an issue with a new query and I will add it to the gem. Or you can submit a PR with the JSON for the query added to the repo.

### Leads
[Close API Docs](https://developer.close.com/resources/leads/)

### Custom Activity Types
[Close API Docs](https://developer.close.com/resources/custom-activities/custom-activity-types/)

#### .list
```ruby
Close::CustomActivityType.list # => Array of [CustomActivityType]
```

#### .retrieve
```ruby
Close::CustomActivityType.retrieve('custom_activity_type_id') # => CustomActivityType
```

#### .create
```ruby
Close::CustomActivityType.create({name: 'Custom Activity Type Name'}) # => CustomActivityType
```

#### #update
```ruby
custom_activity_type = Close::CustomActivityType.retrieve('custom_activity_type_id')
custom_activity_type.name = 'New Name'
custom_activity_type.update # => Boolean
```



## Documentation

Aside from this README, you can find the documentation for this gem at [rubydoc.info](https://www.rubydoc.info/gems/close).

You can also generate the documentation locally by running:

    $ bundle exec rake yard



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/JoyNerd/close. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/JoyNerd/close/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Close project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/close/blob/master/CODE_OF_CONDUCT.md).
