# FactoryHen

Small and simple Factory for ActiveModels

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'factory_hen'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install factory_hen

## Usage

Create a file to contain your factories. For example:

```ruby
# spec/factories.rb

FactoryHen.configure do |factory|
  factory.define :user do
    { email: "a string",
      password: "password",
      password_confirmation: "password"}
  end

  factory.define :location do
    { address: FFaker::AddressSE.street_address,
      city: FFaker::AddressSE.city,
      company: FactoryHen.create(:company),
      lng: FFaker::Geolocation.lng,
      lat: FFaker::Geolocation.lat }
  end
end
```

Require FactoryHen and your newly created factories in by adding the following lines to your
spec/spec_helper.rb:

```ruby
require'factory_hen'
require'factories'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rk222ev/factory_hen.

