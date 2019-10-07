# Heartcheck::Paypal

##A plugin to check Paypal Api connectivity with [heartcheck](https://github.com/locaweb/heartcheck) and [paypal-sdk-rest](https://github.com/paypal/PayPal-Ruby-SDK).

It checks the first stage(create payment) of payment's Paypal Api.

[![Build Status](https://travis-ci.org/locaweb/heartcheck.svg)](https://travis-ci.org/feolea/heartcheck-paypal)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'heartcheck-paypal'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install heartcheck-paypal

## Usage

With this basic setup, the gem will use your app default paypal credentials:

```ruby
Heartcheck.setup do |monitor|
  monitor.add :paypal do |config|
    config.add_service(name: :paypal)
  end
end
```

Or you can add desired paypal account to monitoring if you want to use another account.

```ruby
Heartcheck.setup do |monitor|
  monitor.add :paypal do |config|
    config.add_service(
      {
        client_id: 'your_client_hash_at_paypal',
        client_secret: 'your_secret_hash_at_paypal',
        mode: 'sandbox' # or live to production!,
        order: { paypal: :order } # optional if you want to test with your order attrs, please refer to paypal docs to proper payload.
      }
    )
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/feolea/heartcheck-paypal. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Heartcheck::Paypal project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/heartcheck-paypal/blob/master/CODE_OF_CONDUCT.md).
