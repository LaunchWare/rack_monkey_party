# RackMonkeyParty

[![Build Status](https://secure.travis-ci.org/EnlightSolutions/rack_monkey_party.png)](http://travis-ci.org/EnlightSolutions/rack_monkey_party)

A rack endpoint for adding people to a mailchimp list

## Installation and configuration

Add this line to your application's Gemfile:

    gem 'rack_monkey_party'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack_monkey_party

Configure mailchimp parameters
```ruby
  MonkeyParty.api_key = 'an_api_key'
  MonkeyParty.data_center = 'us1'
  MonkeyParty.default_list = 'Your List Name'
```

## Usage

Perform a post to the app with a JSON-based, subscriber payload

```ruby
  post "/", { "subscriber" => {"email" => "user@example.com" }}
```

If the request successfully processes,
you should receive a 201 (created) response.
This means that the email address was successfully added to the desired list

If something went wrong you should receive a 421 (unprocessable entity). 
You will also receive the error message received from MailChimp.

```javascript
  {
    email: "bademail",
    error: {
      message: "Invalid Email Address: bademail", 
      code: "502"
    }
  }
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

